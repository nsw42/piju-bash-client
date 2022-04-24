#! /bin/bash

function usage() {
  echo Usage: $0 PLAYLISTID
  exit 1
}

source "$(dirname $0)/lib_piju_client.sh"

playlistid=$1
if [ -z "$playlistid" ]; then
  usage
fi

curl -X DELETE "$PIJU_BASE_URL/playlists/$playlistid"
