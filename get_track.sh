#! /bin/bash

source "$(dirname $0)/lib_piju_client.sh"

set -e
set -o pipefail

trackid=$1
if [ -z "$trackid" ]; then
  echo Usage: $0 TRACKID
  exit 1
fi

infolevel=$2

if [ "$infolevel" ]; then
  infolevel="?infolevel=$infolevel"
fi


curl -sf "$PIJU_BASE_URL/tracks/$trackid$infolevel" | jq
