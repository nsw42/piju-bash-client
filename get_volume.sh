#! /bin/bash

source "$(dirname $0)/lib_piju_client.sh"

curl "$PIJU_BASE_URL/player/volume"

