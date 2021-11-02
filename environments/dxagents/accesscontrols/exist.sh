#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
CHILD=$2
GCHILD=$3
ATTR=$4
READ=$(bash "${MYPATH}/read.sh" "$NAME" "$CHILD" "$GCHILD" "$ATTR")
echo "$READ"
TYPE=$(echo "$READ" | ./jq  -r 'type')
if [ "$TYPE" == "object" ]; then
    if [ $(echo "$READ" | ./jq '.statusCode') == "404" ]; then
        exit 1
    fi
    if [ $(echo "$READ" | ./jq '.statusCode') == "400" ]; then
        exit 1
    fi
else
    if [ $(echo "$READ" | ./jq 'length') == "0" ]; then
        exit 1
    fi
fi
