#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
NAME=$1
CHILD=$2
GCHILD=$3
G2CHILD=$4
if ! EXIST=$(bash "${DIRNAME}/exist.sh" "$NAME" "$CHILD" "$GCHILD" "$G2CHILD"); then
    STATUS=1
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
