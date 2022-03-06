#! /bin/bash

source "$(dirname $0)/lib_piju_client.sh"

curl -X POST "$PIJU_BASE_URL/player/pause"
