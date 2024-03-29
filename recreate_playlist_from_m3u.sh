#! /bin/bash

function usage() {
  echo Usage: $0 BASEMUSICDIR PLAYLISTID TITLE M3U
}

source "$(dirname $0)/lib_piju_client.sh"

basedir=$1
playlistid=$2
title=$3
m3u=$4

if [ -z "$m3u" ]; then
  usage
  exit 1
fi

(echo -n '{"title": "'$title'", "files": ['
 cat "$m3u" | tr '' '\n' | grep -v '^#' | grep -v '^$' | sed 's/"//' | sed "s:$basedir::" | awk '{print join "\"" $0 "\""; join=","}'; echo ']}') | curl -s -X PUT "${CONTENT_TYPE[@]}" --data-binary @- "$PIJU_BASE_URL/playlists/$playlistid"
