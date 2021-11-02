#!/bin/bash
NAME=$1
JSON=$2
MYPATH=$(dirname "$0")
if [[ -z "${NAME}" ]]; then
    ./jq -n '{"message": "Environment name is required", "statusCode": 404}'
    exit 1
fi
if [[ -z "$JSON" ]] ; then
    >&2 echo "JSON formatted payload file required"
    exit 1
fi
ADDL="--header,Content-Type: application/json,--header,Accept: application/json,-d,@$JSON"
bash "${MYPATH}/coreZ01/put.sh" "$NAME" "" "$ADDL"
