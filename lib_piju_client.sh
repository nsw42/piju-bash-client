# do not exec me

if [ -z "$PIJU_HOST" ]; then
  echo "WARNING: Using default host 'piju'" > /dev/stderr
  echo "To override: export PIJU_HOST=hostname" > /dev/stderr
  PIJU_HOST=piju
fi

PIJU_BASE_URL="http://$PIJU_HOST:5000"
declare -a CONTENT_TYPE
CONTENT_TYPE[0]="-H"
CONTENT_TYPE[1]="Content-Type: application/json"

function genre_track_info_level() {
  genres=$1
  tracks=$2

  if [ "$genres" ]; then
    genres="genres=$genres"
  fi
  if [ "$tracks" ]; then
    tracks="tracks=$tracks"
  fi
  
  if [ "$genres" -a "$tracks" ]; then
    args="?$genres&$tracks"
  elif [ "$genres" ]; then
    args="?$genres"
  elif [ "$tracks" ]; then
    args="?$tracks"
  else
    args=
  fi
  echo "$args"
}
