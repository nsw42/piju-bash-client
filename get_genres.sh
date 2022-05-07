#! /bin/bash

source "$(dirname $0)/lib_piju_client.sh"

curl -s "$PIJU_BASE_URL/genres/" | jq 'sort_by(.link[8:] | tonumber)'
