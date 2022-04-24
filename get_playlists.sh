#! /bin/bash

source "$(dirname $0)/lib_piju_client.sh"

curl -s "$PIJU_BASE_URL/playlists/" | jq
