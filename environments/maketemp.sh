#!/bin/bash
NAME=$1
MYPATH=$(dirname "$0")
if [[ -z "${NAME}" ]]; then
    ./jq -n '{"message": "Environment name is required", "statusCode": 404}'
    exit 1
fi
EXIST=$(bash ${MYPATH}/exist.sh "$NAME")
STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo "$EXIST"
    exit "$STATUS"
fi
echo '#!/bin/bash'
echo 'NAME=$1'
echo 'cat <<EOF'
echo "$EXIST" | ./jq '. + { "name": "${NAME}" }'
echo 'EOF'
