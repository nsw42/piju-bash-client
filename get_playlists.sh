#! /bin/bash

source "$(dirname $0)/lib_piju_client.sh"

genres=$1
tracks=$2

args=$(genre_track_info_level $genres $tracks)

curl -s "$PIJU_BASE_URL/playlists/$args" | jq
