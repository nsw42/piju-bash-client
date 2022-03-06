# do not exec me

if [ -z "$PIJU_HOST" ]; then
  echo "WARNING: Using default host 'piju'"
  echo "To override: export PIJU_HOST=hostname"
  PIJU_HOST=piju
fi

PIJU_BASE_URL="http://$PIJU_HOST:5000"
declare -a CONTENT_TYPE
CONTENT_TYPE[0]="-H"
CONTENT_TYPE[1]="Content-Type: application/json"
