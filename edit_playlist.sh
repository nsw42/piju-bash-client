#! /bin/bash

function usage() {
  echo Usage: $0 PLAYLISTID TITLE TRACKID...
}

source "$(dirname $0)/lib_piju_client.sh"

if [ "${#}" -lt 3 ]; then
  usage
  exit 1
fi

playlistid=$1
shift

title=$1
shift

tracklist=
for trackid; do
  if [ "$tracklist" ]; then
    tracklist="${tracklist}, "
  fi
  tracklist="${tracklist}${trackid}"
done

curl -X PUT "${CONTENT_TYPE[@]}" -d "{\"title\": \"$title\", \"tracks\": [$tracklist]}" "$PIJU_BASE_URL/playlists/$playlistid"
