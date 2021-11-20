#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
ENVNAME=$1
if [[ -z "${ENVNAME}" ]]; then
    ./jq -n ' . + {"message": "Environment name is required", "statusCode": 404}'
    exit 1
fi
EXIST=$(bash "$MYPATH/../exist.sh" "$ENVNAME"); STATUS=$?
if [ "$STATUS" -ne 0 ] ; then
    ./jq -n ' . + {"message": "Environment does note exist", "statusCode": 404}'
    exit "$STATUS"
fi
OUTPUT="[]"
LIST=$(bash "$MYPATH/../dxagents/list.sh" "$ENVNAME")
LEN=$(echo "$LIST" | ./jq 'length')
for (( i = 0; i < $LEN ; ++i )) ; do
    DXA=$(echo "$LIST" | ./jq -r ".[$i]")
    DSAs=$(bash "$MYPATH/../dxagents/dsas/list.sh" "$ENVNAME" "$DXA")
    OUTPUT=$(echo "$OUTPUT" | ./jq --arg x "$DXA" --argjson s "$DSAs" \
        '. += [ { "dxagent": $x, "dsas": $s } ]')
done
echo "$OUTPUT" | ./jq '.'
