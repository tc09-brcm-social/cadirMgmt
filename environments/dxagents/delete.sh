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
   bash "${MYPATH}/coreZ0101/delete.sh" "$NAME" "$CHILD"
