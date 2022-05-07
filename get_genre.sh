#! /bin/bash

source "$(dirname $0)/lib_piju_client.sh"

genre_id=$1
if [ -z "$genre_id" ]; then
  echo "Usage: $0 GENREID [ALBUMINFOLEVEL] [PLAYLISTINFOLEVEL]"
  echo "ALBUMINFOLEVEL and PLAYLISTINFOLEVEL can each be one of '', 'none', 'all' or 'links' (the default)"
  exit 1
fi

albuminfolevel=$2
playlistinfolevel=$3
if [ "$albuminfolevel" ]; then
  albuminfolevel="albums=$albuminfolevel"
fi
if [ "$playlistinfolevel" ]; then
  playlistinfolevel="playlists=$playlistinfolevel"
fi
if [ "$albuminfolevel" -a "$playlistinfolevel" ]; then
  args="?${albuminfolevel}&${playlistinfolevel}"
elif [ "$albuminfolevel" ]; then
  args="?${albuminfolevel}"
elif [ "$playlistinfolevel" ]; then
  args="?${playlistinfolevel}"
else
  args=
fi

set -e
set -o pipefail
curl -sf --show-error "$PIJU_BASE_URL/genres/${genre_id}${args}" | jq
