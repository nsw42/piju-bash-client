#! /bin/bash

source "$(dirname $0)/lib_piju_client.sh"

playlist_id=$1
if [ -z "$playlist_id" ]; then
  echo "Usage: $0 PLAYLISTID [TRACKINFOLEVEL]"
  echo "TRACKINFOLEVEL can be one of 'none', 'all' or 'links' (the default)"
  exit 1
fi

trackinfolevel=$2
set -e
set -o pipefail
if [ -z "$trackinfolevel" ]; then
  curl -sf --show-error "$PIJU_BASE_URL/playlists/$playlist_id" | jq
else
  curl -sf --show-error "$PIJU_BASE_URL/playlists/$playlist_id?tracks=$trackinfolevel" | jq
fi
