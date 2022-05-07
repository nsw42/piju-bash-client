#! /bin/bash

source "$(dirname $0)/lib_piju_client.sh"

volume=$1

curl -X POST "${CONTENT_TYPE[@]}" -d '{"volume": '$volume'}'  "$PIJU_BASE_URL/player/volume"

