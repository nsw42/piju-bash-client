
source lib_piju_client.sh

trackid=$1
# TODO: Check $trackid is numeric
set -x
curl -X POST "${CONTENT_TYPE[@]}" -d '{"track": '$trackid'}' "$PIJU_BASE_URL/player/play"
