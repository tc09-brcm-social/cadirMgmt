#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
ENVNAME=$1
CHILD=$2
if [[ -z "${ENVNAME}" ]]; then
    ./jq -n ' . + {"message": "Environment name is required", "statusCode": 404}'
    exit 1
fi
if [[ -z "$CHILD" ]] ; then
    ./jq -n ' . + {"message": "dxagent name is required", "statusCode": 404}'
    exit 1
fi
    bash "${DIRNAME}/coreZ01010/get.sh" "$ENVNAME" "$CHILD" | ./jq -r '.'
