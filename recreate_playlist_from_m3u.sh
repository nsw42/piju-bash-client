#! /bin/bash

function usage() {
  echo Usage: $0 PLAYLISTID TITLE M3U
}

source "$(dirname $0)/lib_piju_client.sh"

playlistid=$1
title=$2
m3u=$3

if [ -z "$m3u" ]; then
  usage
  exit 1
fi

(echo -n '{"title": "'$title'", "files": ['
 cat $m3u | grep -v '^#' | grep -v '^$' | sed 's/"//' | awk '{print join "\"" $0 "\""; join=","}'; echo ']}') | curl -X PUT "${CONTENT_TYPE[@]}" --data-binary @- "$PIJU_BASE_URL/playlists/$playlistid"
