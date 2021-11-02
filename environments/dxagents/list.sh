#!/bin/bash
ENVNAME=$1
NAME=$2
MYPATH=$(dirname "$0")
EXIST=$(bash "${MYPATH}/exist.sh" "$ENVNAME" "$NAME" name)
STATUS=$?
if [ $STATUS -ne 0 ]; then
    ./jq -n '[]'
    exit "$STATUS"
fi
if [ $(echo "$EXIST" | ./jq -r 'type') == "object" ]; then
    echo "$EXIST" | ./jq '[.name]'
else
    echo "$EXIST" | ./jq '[.[]| .name]'
fi

