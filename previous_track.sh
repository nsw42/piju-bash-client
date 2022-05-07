#! /bin/bash

source lib_piju_client.sh

set -x
curl -X POST "${CONTENT_TYPE[@]}" "$PIJU_BASE_URL/player/previous"
