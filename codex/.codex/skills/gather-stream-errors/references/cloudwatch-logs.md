# Production stream logs through AWS MCP

The user-supplied Logs Insights query is:

```text
SOURCE "/ecs/task/production/rr-periscope-app-logs" START=-1w END=0s |
fields @timestamp, timestamp, camMACAddress, appVersion, message, @message
| filter streamId = '__STREAM_ID__'
| filter level in ['info','error']
| sort @timestamp desc
```

Replace `__STREAM_ID__` with the stream ID provided for the current request. Escape a literal backslash as `\\` and a single quote as `\'` when rendering the filter; never concatenate an unescaped user value. Do not rename `steamId` or change the level filter. The log group can be overridden by `CLOUDWATCH_LOG_GROUP` in the separate environment file; use `CLOUDWATCH_REGION` for the confirmed log group Region.

## Execute with AWS MCP

Use AWS MCP's API execution tool (`run_script`, currently exposed as `aws___run_script`). Its `call_boto3` helper takes PascalCase operation names. For the Logs Insights API, express `SOURCE` and `START`/`END` with `logGroupName`, `startTime`, and `endTime`; send the pipeline beginning at `fields` as `queryString`. This preserves the user's source, relative time window, fields, filters, and ordering.

Resolve the current stream ID, environment settings, and Region before adapting this example. Keep them as Python string data, never executable code interpolated from the user input. Epoch timestamps are in seconds, and the seven-day window is calculated once at query start.

```python
stream_id = "USER_PROVIDED_STREAM_ID"
region = "CONFIRMED_LOG_GROUP_REGION"
log_group = "/ecs/task/production/rr-periscope-app-logs"
if not stream_id or stream_id == "USER_PROVIDED_STREAM_ID":
    raise ValueError("A stream ID is required")

end_time = int(time.time())
start_time = end_time - 7 * 24 * 60 * 60
escaped_id = stream_id.replace("\\", "\\\\").replace("'", "\\'")
query = (
    "fields @timestamp, timestamp, camMACAddress, appVersion, message, @message\n"
    "| filter streamId = '" + escaped_id + "'\n"
    "| filter level in ['info','error']\n"
    "| sort @timestamp desc"
)
response = await call_boto3(
    service_name="logs",
    operation_name="StartQuery",
    region_name=region,
    params={
        "logGroupName": log_group,
        "startTime": start_time,
        "endTime": end_time,
        "queryString": query,
    },
)
result = {
    "streamId": stream_id,
    "region": region,
    "logGroup": log_group,
    "startTime": start_time,
    "endTime": end_time,
    "queryId": response["queryId"],
}
result
```

Poll `GetQueryResults` for the returned `queryId`, in the same Region. Carry forward the ID and time window instead of restarting the query. Wait briefly between polls; keep individual waits under 60 seconds. `Scheduled` and `Running` results are provisional. On `Complete`, preserve raw fields, inspect statistics, and retrieve subsequent result pages if `nextToken` is returned. If an AWS MCP invocation itself returns a working task, poll `get_tasks` for that task before continuing the CloudWatch query. These are distinct IDs.

```python
response = await call_boto3(
    service_name="logs",
    operation_name="GetQueryResults",
    region_name=region,
    params={"queryId": query_id},
)
result = response
result
```

Treat `Failed`, `Cancelled`, `Timeout`, and `Unknown` as unsuccessful query states. Stop routine polling after two minutes and report the query ID and pending status; do not claim completion or start a duplicate query. Report IAM/access errors directly without requesting or exposing credentials. Verify the MCP response's `api_calls` actually ran the requested AWS operations.

Do not silently impose a result limit. If the service limits the result set, report truncation and use nonoverlapping smaller time windows when the user needs all matching events. Report `recordsMatched` and actual returned rows when available; a count of returned rows alone may not describe the full matching set.
