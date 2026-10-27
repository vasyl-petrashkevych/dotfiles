#!/usr/bin/env python3
"""Read-only RapidReplay GraphQL requests using separate environment settings."""

import argparse
import json
import os
from pathlib import Path
import re
import sys
import urllib.error
import urllib.parse
import urllib.request


def read_env(path):
    values = {}
    if path.exists():
        for line in path.read_text().splitlines():
            line = line.strip()
            if not line or line.startswith('#'):
                continue
            key, separator, value = line.partition('=')
            if not separator:
                raise ValueError('Invalid environment entry; expected KEY=VALUE.')
            value = value.strip()
            if len(value) >= 2 and value[0] == value[-1] and value[0] in "\"'":
                value = value[1:-1]
            values[key.strip()] = value
    values.update(os.environ)
    return values


def schema_query():
    ref = 'kind name'
    for _ in range(7):
        ref = 'kind name ofType { ' + ref + ' }'
    return ('query InspectStreamSchema { __schema { queryType { name } '
            'types { kind name fields { name args { name type { ' + ref +
            ' } } type { ' + ref + ' } } inputFields { name type { ' + ref +
            ' } } } } }')


class NoRedirect(urllib.request.HTTPRedirectHandler):
    def redirect_request(self, req, fp, code, msg, headers, newurl):
        return None


def request_graphql(env, query, variables):
    endpoint = env.get('RAPIDREPLAY_GRAPHQL_URL', '').strip()
    token = env.get('RAPIDREPLAY_BEARER_TOKEN', '').strip()
    if not endpoint or not token:
        raise ValueError('Set RAPIDREPLAY_GRAPHQL_URL and RAPIDREPLAY_BEARER_TOKEN in the environment file.')
    parsed = urllib.parse.urlsplit(endpoint)
    if parsed.scheme != 'https' or not parsed.hostname or parsed.username or parsed.password:
        raise ValueError('The GraphQL URL must use HTTPS without embedded credentials.')
    if '\n' in token or '\r' in token:
        raise ValueError('The bearer token must be a single line.')
    payload = {'query': query, 'variables': variables}
    request = urllib.request.Request(endpoint, data=json.dumps(payload).encode(),
                                     headers={'Authorization': 'Bearer ' + token,
                                              'Content-Type': 'application/json',
                                              'Accept': 'application/json',
                                              'User-Agent': 'RapidReplayStreamDiagnostics/1.0'})
    opener = urllib.request.build_opener(NoRedirect())
    try:
        with opener.open(request, timeout=30) as response:
            body = response.read()
    except urllib.error.HTTPError as exc:
        # Avoid echoing proxy/error pages, which can contain credentials.
        raise ValueError('GraphQL HTTP request failed: ' + str(exc.code)) from None
    except (urllib.error.URLError, TimeoutError):
        raise ValueError('GraphQL connection failed or timed out') from None
    result = json.loads(body)
    if not isinstance(result, dict) or not ('data' in result or 'errors' in result):
        raise ValueError('The server returned an invalid GraphQL response envelope.')
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('stream_id', nargs='?')
    parser.add_argument('--env-file', type=Path,
                        default=Path(__file__).resolve().parents[1] / '.env')
    parser.add_argument('--query-file', type=Path)
    parser.add_argument('--id-variable', default='liveStreamsPrivateId')
    parser.add_argument('--inspect-schema', action='store_true')
    args = parser.parse_args()
    if args.inspect_schema and (args.query_file or args.stream_id):
        parser.error('--inspect-schema cannot be combined with a stream query')
    if not args.inspect_schema and not args.stream_id:
        parser.error('provide STREAM_ID, or --inspect-schema')
    try:
        env = read_env(args.env_file)
        query_file = args.query_file or Path(__file__).resolve().parents[1] / 'references' / 'stream-info.graphql'
        query = schema_query() if args.inspect_schema else query_file.read_text()
        # Reject shorthand and non-query operations; ignore comments and strings.
        operation_text = re.sub(r'"""[\s\S]*?"""|"(?:\\.|[^"\\])*"|#[^\n]*', '', query)
        if not re.match(r'\s*query\b', operation_text) or re.search(r'\b(mutation|subscription)\b', operation_text):
            raise ValueError('Only explicit GraphQL query operations are supported.')
        payload = {'query': query, 'variables': {} if args.inspect_schema else {args.id_variable: args.stream_id}}
        result = request_graphql(env, query, payload['variables'])
        print(json.dumps(result, indent=2))
        return 1 if result.get('errors') else 0
    except (OSError, ValueError):
        print(json.dumps({'error': 'Check environment settings, query file, and JSON response format. No request credentials are displayed.'}), file=sys.stderr)
        return 1


if __name__ == '__main__':
    sys.exit(main())
