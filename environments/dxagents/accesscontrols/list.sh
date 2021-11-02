#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
NAME=$1
CHILD=$2
GCHILD=$3
if ! EXIST=$(bash "${DIRNAME}/exist.sh" "$NAME" "$CHILD" "$GCHILD"); then
    STATUS=$?
    ./jq -n '. + []'
    exit "$STATUS"
fi
TYPE=$(echo "$EXIST" | ./jq -r 'type')
if [ "$TYPE" == "object" ]; then
    echo "$EXIST" | ./jq '[ .name ]'
fi
if [ "$TYPE" == "array" ]; then
    echo "$EXIST" | ./jq '[.[]| .name]'
fi
