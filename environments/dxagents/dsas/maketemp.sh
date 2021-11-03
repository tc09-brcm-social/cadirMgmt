#!/bin/bash
NAME=$1
CHILD=$2
GRANDCHILD=$3
MYPATH=$(dirname "$0")
if [[ -z "${GRANDCHILD}" ]]; then
    ./jq -n ' . + {"message": "DSA name is required", "statusCode": 404}'
    exit
fi
EXIST=$(bash ${MYPATH}/exist.sh "$NAME" "$CHILD" "$GRANDCHILD")
STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo "$EXIST"
    exit "$STATUS"
fi
echo '#!/bin/bash'
echo 'NAME=$1'
echo 'cat <<EOF'
echo "$EXIST" | bash "${MYPATH}/cleanse.sh" | \
    ./jq -S '. + { "name": "${NAME}", "status": "stopped" }' | \
    sed 's/\(\$[^{]\)/\\\1/g'
echo 'EOF'
