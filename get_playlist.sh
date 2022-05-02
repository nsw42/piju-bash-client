#! /bin/bash

source "$(dirname $0)/lib_piju_client.sh"

playlist_id=$1
if [ -z "$playlist_id" ]; then
  echo "Usage: $0 PLAYLISTID [GENREINFOLEVEL] [TRACKINFOLEVEL]"
  echo "GENREINFOLEVEL and TRACKINFOLEVEL can be one of 'none', 'all' or 'links'"
  exit 1
fi

genres=$2
tracks=$3
args=$(genre_track_info_level $genres $tracks)
curl -sf --show-error "$PIJU_BASE_URL/playlists/$playlist_id$args" | jq
set -e
set -o pipefail
