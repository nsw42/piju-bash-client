#! /bin/bash

source "$(dirname $0)/lib_piju_client.sh"

album_id=$1
if [ -z "$album_id" ]; then
  echo "Usage: $0 ALBUMID [TRACKINFOLEVEL]"
  echo "TRACKINFOLEVEL can be one of 'none', 'links' (the default), 'all' or 'debug'"
  exit 1
fi

trackinfolevel=$2
set -e
set -o pipefail
if [ "$trackinfolevel" ]; then
  trackinfolevel="?tracks=$trackinfolevel"
fi

curl -sf --show-error "$PIJU_BASE_URL/albums/$album_id$trackinfolevel" | jq
