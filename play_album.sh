
source lib_piju_client.sh

albumid=$1
# TODO: Check $albumid is numeric
set -x
curl -X POST "${CONTENT_TYPE[@]}" -d '{"album": '$albumid'}' "$PIJU_BASE_URL/player/play"
