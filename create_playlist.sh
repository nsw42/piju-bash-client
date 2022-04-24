#! /bin/bash

function usage() {
  echo Usage: $0 TITLE TRACKID...
}

source "$(dirname $0)/lib_piju_client.sh"

if [ "${#}" -lt 2 ]; then
  usage
  exit 1
fi

title=$1
shift

tracklist=
for trackid; do
  if [ "$tracklist" ]; then
    tracklist="${tracklist}, "
  fi
  tracklist="${tracklist}${trackid}"
done

curl -X POST "${CONTENT_TYPE[@]}" -d "{\"title\": \"$title\", \"tracks\": [$tracklist]}" "$PIJU_BASE_URL/playlists/"
