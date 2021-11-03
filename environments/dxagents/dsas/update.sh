#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
MYPATH=$(cd $(dirname "$0"); pwd)
NAME=$1
CHILD=$2
GCHILD=$3
JSON=$4
if [[ -z "${NAME}" ]]; then
    ./jq -n ' . + {"message": "Environment name is required", "statusCode": 404}'
    exit 1
fi
if [[ -z "${CHILD}" ]]; then
    ./jq -n ' . + {"message": "dxagent name is required", "statusCode": 404}'
    exit 1
fi
if [[ -z "${GCHILD}" ]]; then
    ./jq -n ' . + {"message": "DSA name is required", "statusCode": 404}'
    exit 1
fi
if [[ -z "${JSON}" ]]; then
    ./jq -n ' . + {"message": "JSON payload is required", "statusCode": 404}'
    exit 1
fi
ADDL="--header,Content-Type: application/json,--header,Accept: application/json,-d,@$JSON"
bash "${MYPATH}/coreZ010101/put.sh" "$NAME" "$CHILD" "$GCHILD" "" "$ADDL"
