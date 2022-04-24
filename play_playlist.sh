#! /bin/bash

function usage() {
  echo "Usage: $0 PLAYLISTID [TRACKID]"
  exit 1
}

source lib_piju_client.sh

playlistid=$1
if [ -z "$playlistid" ]; then usage; fi
# TODO: Check $playlistid is numeric

trackid=$2

set -x

if [ -z "$trackid" ]; then
  curl -X POST "${CONTENT_TYPE[@]}" -d '{"playlist": '$playlistid'}' "$PIJU_BASE_URL/player/play"
else
  curl -X POST "${CONTENT_TYPE[@]}" -d '{"playlist": '$playlistid', "track": '$trackid'}' "$PIJU_BASE_URL/player/play"
fi
