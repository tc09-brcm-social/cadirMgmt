#!/bin/bash
NAME=$1
CHILD=$2
GRANDCHILD=$3
MYPATH=$(dirname "$0")
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
MYBASE=$(basename "$DIRNAME")
if [[ -z "${GRANDCHILD}" ]]; then
    ./jq -n --arg n "$MYBASE" ' . + {"message": ($n + " name is required"), "statusCode": 404}'
    exit
fi
EXIST=$(bash ${MYPATH}/exist.sh "$NAME" "$CHILD" "$GRANDCHILD" "data,readOnly,name")
STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo "$EXIST"
    exit "$STATUS"
fi
echo '#!/bin/bash'
echo 'NAME=$1'
echo 'cat <<EOF'
echo "$EXIST" | \
    ./jq '. + { "name": "${NAME}" }'
echo 'EOF'
