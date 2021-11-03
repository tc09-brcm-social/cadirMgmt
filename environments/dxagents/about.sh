#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
NAME=$1
CHILD=$2
if [[ -z "${NAME}" ]]; then
    ./jq -n '{"message": "Environment name is required", "statusCode": 404}'
    exit 1
fi
if [[ -z "${CHILD}" ]]; then
    ./jq -n '{"message": "dxagent name is required", "statusCode": 404}'
    exit 1
fi
EXIST=$(bash "${MYPATH}"/exist.sh "$NAME" "$CHILD" installationInfo); STATUS=$?
if [ "$STATUS" -ne 0 ] ; then
    echo "$EXIST"
    exit "$STATUS"
fi
echo "$EXIST" | ./jq '.installationInfo | fromjson' 
