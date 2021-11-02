#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
READ=$(bash "${MYPATH}/read.sh" "$NAME")
echo "$READ"
if [ $(echo "$READ" | ./jq -r 'type') == "object" ]; then
    if [ $(echo "$READ" | ./jq -r '.statusCode') == "404" ]; then
        exit 1
    fi
fi
