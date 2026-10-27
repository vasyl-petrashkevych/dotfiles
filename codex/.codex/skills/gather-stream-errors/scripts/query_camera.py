#!/usr/bin/env python3
"""Fetch a camera and its directly linked scoreboard camera, when present."""

import argparse
import json
from pathlib import Path
import sys

from query_stream import read_env, request_graphql


def gather_camera(env, camera_id):
    query = (Path(__file__).resolve().parents[1] / 'references' / 'camera-info.graphql').read_text()
    primary = request_graphql(env, query, {'ids': [camera_id]})
    result = {'cameraResponse': primary, 'scoreboardCameraResponse': None}
    cameras = (primary.get('data') or {}).get('fetchCameras')
    if cameras is None:
        return result
    if not isinstance(cameras, list):
        raise ValueError('Unexpected fetchCameras response shape.')
    primary_camera = next((camera for camera in cameras if camera and camera.get('id') == camera_id), None)
    scoreboard_id = primary_camera.get('scoreboardCameraId') if primary_camera else None
    if scoreboard_id is not None:
        if scoreboard_id == camera_id:
            result['scoreboardCameraResponse'] = primary
        else:
            try:
                result['scoreboardCameraResponse'] = request_graphql(env, query, {'ids': [scoreboard_id]})
            except (OSError, ValueError):
                # Preserve the successfully retrieved primary camera on a follow-up failure.
                result['scoreboardCameraResponse'] = {'errors': [{'message': 'Scoreboard camera request failed.'}]}
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('camera_id')
    parser.add_argument('--env-file', type=Path,
                        default=Path(__file__).resolve().parents[1] / '.env')
    args = parser.parse_args()
    try:
        result = gather_camera(read_env(args.env_file), args.camera_id)
        print(json.dumps(result, indent=2))
        return int(any(response and response.get('errors') for response in result.values()))
    except (OSError, ValueError):
        print(json.dumps({'error': 'Camera request failed; check environment settings and API response.'}), file=sys.stderr)
        return 1


if __name__ == '__main__':
    sys.exit(main())
