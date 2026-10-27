---
name: gather-stream-errors
description: Fetch RapidReplay stream and camera diagnostics through GraphQL and production CloudWatch info/error logs through AWS MCP for a user-supplied stream ID. Also retrieve a linked scoreboard camera when present.
---

# Gather stream errors

Use the read-only GraphQL API at `https://api-dev.rapidreplay.co/graphql` to retrieve a stream by ID. Use the connected AWS MCP server for CloudWatch log searches. Environment-specific values and the bearer token belong in the separate `.env` file beside this skill, never in these instructions or a query file.

## Configuration

The `.env` file uses `RAPIDREPLAY_GRAPHQL_URL` and `RAPIDREPLAY_BEARER_TOKEN`. Set the token locally without pasting it into chat. The helper reads this file as data without executing shell commands. Existing process environment variables override the file. An alternative file can be supplied with `--env-file`.

`CLOUDWATCH_LOG_GROUP` selects the log group (default `/ecs/task/production/rr-periscope-app-logs`), and `CLOUDWATCH_REGION` selects its AWS Region. Keep these settings in the same separate `.env` file. AWS authentication comes from the connected AWS MCP server; the GraphQL bearer token is not an AWS credential. Read only the settings needed without displaying the full environment file.

If the token is missing, explain which local setting needs filling in; do not invent credentials. Do not display the token, authorization header, or full environment file.

## Retrieve a stream

1. Obtain the stream ID from the request or existing context. Treat it as an opaque identifier.
2. Run the bundled, user-supplied [stream query](references/stream-info.graphql):

   ```sh
   python3 <skill-dir>/scripts/query_stream.py STREAM_ID
   ```

   It queries `liveStreamsPrivate(isDeleted: false, id: $liveStreamsPrivateId)` with `$liveStreamsPrivateId: ID`, selecting `count` and `data { eventName camera { id } visionularStreamId }`. Preserve the exact `visionularStreamId` capitalization. Inspect `data.liveStreamsPrivate.count` and its `data` array to determine whether a stream was found.
3. For each returned stream camera ID, run the camera workflow below to retrieve camera details and its linked scoreboard camera. To retrieve the additional requested `cameraInfo` and `streamUrl` fields, first verify their schema location and selection shape. The supplied query does not establish whether these are stream fields, camera fields, objects, or scalars. Inspect the schema when necessary:

   ```sh
   python3 <skill-dir>/scripts/query_stream.py --inspect-schema
   ```

   If introspection is disabled, request the relevant schema or an expanded working query. Do not discard the working base lookup while resolving additional fields. A verified expanded query may be supplied with `--query-file /tmp/stream-info.graphql`. Custom queries use `$liveStreamsPrivateId` by default; specify `--id-variable id` for a query using `$id`.
4. The helper sends bearer authentication, JSON content headers, and an explicit `User-Agent: RapidReplayStreamDiagnostics/1.0`. The default Python urllib user agent caused Cloudflare error 1010 in a live test; the explicit application user agent succeeded with the same endpoint and token. Keep that header. A 403 alone does not establish an invalid token. The helper accepts query operations only, preserves partial data, and exits nonzero for transport failures, invalid responses, or GraphQL errors, including HTTP 200 responses containing errors.
5. Retrieve CloudWatch logs for the user-supplied stream ID using the workflow below.
6. Report the stream ID, requested fields, and any returned API errors. Distinguish an absent stream, a null field, and a failed request. Do not infer an upstream streaming failure solely from an API error. Preserve useful camera diagnostics, but redact passwords, credentials, and signed URL parameters from the chat summary; raw `cameraInfo` and `streamUrl` can contain secrets. Do not persist raw responses unless requested.

## Retrieve camera and scoreboard camera information

Use the camera's GraphQL `id`, supplied directly or obtained from the stream's `camera.id`. The returned `cameraId` is a connection address and is not the lookup ID.

```sh
python3 <skill-dir>/scripts/query_camera.py CAMERA_ID
```

The helper runs the supplied [FetchCameras query](references/camera-info.graphql) with `ids: [CAMERA_ID]`, using the same separate environment file, authentication, and application user agent as the stream helper. It retrieves `id`, `name`, `cameraId`, `axisConnectionType`, `periscope.appVersion`, `application`, `camFirmwareVersion`, `camArchitecture`, and `scoreboardCameraId`.

When the matching camera's `scoreboardCameraId` is non-null, it runs the same query for that ID. A null link or absent primary camera causes no follow-up request. A self-link reuses the primary response. Retrieve only the directly linked scoreboard camera; do not recursively traverse links.

Output contains `cameraResponse` and `scoreboardCameraResponse`, retaining the GraphQL envelopes and any partial data/errors. The scoreboard response is null when no link was available. A failed follow-up preserves the primary response and returns an error with a nonzero exit code. Distinguish an empty `fetchCameras` list from API failure or a missing link. Handle a null `periscope` without inferring a version. Report primary and scoreboard camera diagnostics separately and redact credentials from connection addresses.

## Retrieve CloudWatch stream logs

Use the connected AWS MCP server to fetch logs with the workflow and query in [references/cloudwatch-logs.md](references/cloudwatch-logs.md). Run it for the stream ID supplied for the current investigation. If no stream ID is available, ask for it before querying. Never submit an empty ID filter or reuse an ID from an unrelated earlier investigation. A camera-only lookup does not establish a stream ID.

The default source is `/ecs/task/production/rr-periscope-app-logs`, time range is the last seven days ending now, and levels are `info` and `error`. Preserve the actual log field `steamId` exactly; it is intentionally spelled differently from `streamId`. Match it to the user-provided stream ID, not the camera ID or `visionularStreamId`. Keep production log searches explicitly labeled even when stream metadata comes from the development GraphQL endpoint.

Use AWS MCP's API execution tool for `StartQuery` and `GetQueryResults`, not shell AWS CLI calls. Reuse the existing AWS MCP authentication. Confirm the configured log group Region; do not infer it from the MCP endpoint Region. If the Region is missing, discover the exact log group in enabled Regions using read-only AWS calls, or ask for it if discovery is unavailable. Verify returned `api_calls` before trusting tool results.

Report the stream ID, AWS Region, log group, UTC time window, query ID, completion status, returned matches, and any retrieval errors or result limits. Include timestamps, `camMACAddress`, `appVersion`, and useful log messages; redact credentials and signed URLs. Treat no matches as no matching logs in that window, not proof the stream is healthy. Only describe a result set as complete after the query finishes and all available result pages have been fetched.

This skill gathers stream metadata, camera diagnostics, API errors, and CloudWatch log evidence. It does not modify streams or probe camera URLs.
