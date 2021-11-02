#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
NAME=$1
CHILD=$2
JSON=$3
if [[ -z "${NAME}" ]]; then
    ./jq -n '{"message": "Environment name is required", "statusCode": 404}'
    exit 1
fi
if [[ -z "${CHILD}" ]]; then
    ./jq -n '{"message": "dxagent name is required", "statusCode": 404}'
    exit 1
fi
if [[ -z "$JSON" ]] ; then
    >&2 echo "JSON formatted payload file required"
    exit 1
fi
ADDL="--header,Content-Type: application/json,--header,Accept: application/json,-d,@$JSON"
   bash "${MYPATH}/coreZ0101/put.sh" "$NAME" "$CHILD" "" "$ADDL"
