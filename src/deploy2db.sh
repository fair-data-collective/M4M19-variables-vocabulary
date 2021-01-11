rawurlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
#   echo "${encoded}"    # You can either set a return variable (FASTER)
  ENCODED_URL="${encoded}"   #+or echo the result (EASIER)... or both... :p
#   export REPLY="${encoded}"
}

rawurlencode "$GRAPH";
curl -X PUT -d @"$FILE_NAME".ttl -u "$DB_USER":"$DB_PASS" -H "Content-Type: application/x-turtle" $SPARQL_ENDPOINT?graph=$ENCODED_URL