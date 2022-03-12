#! /bin/bash

source lib_piju_client.sh

subdir=$1

set -x
if [ -z "$subdir" ]; then
  curl -X POST "${CONTENT_TYPE[@]}" -d '{}' "$PIJU_BASE_URL/scanner/scan"
else
  curl -X POST "${CONTENT_TYPE[@]}" -d '{"dir": "'"$subdir"'"}' "$PIJU_BASE_URL/scanner/scan"
fi
