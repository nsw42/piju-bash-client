
source lib_piju_client.sh

albumid=$1
trackid=$2

if [ "$trackid" ]; then
  request='{"album": '$albumid', "track": '$trackid'}'
else
  request='{"album": '$albumid'}'
fi

# TODO: Check $albumid and $trackid are numeric
set -x
curl -X POST "${CONTENT_TYPE[@]}" -d "$request" "$PIJU_BASE_URL/player/play"
