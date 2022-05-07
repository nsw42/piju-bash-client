#! /bin/bash

source "$(dirname $0)/lib_piju_client.sh"

trackid=$1
if [ -z "$trackid" ]; then
  echo Usage: $0 TRACKID
  exit 1
fi

curl -sf "$PIJU_BASE_URL/tracks/$trackid" | jq
