#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
NAME=$1
CHILD=$2
GCHILD=$3
if [[ -z "${NAME}" ]]; then
    ./jq -n ' . + {"message": "Environment name is required", "statusCode": 404}'
    exit 1
fi
if [[ -z "${CHILD}" ]]; then
    ./jq -n ' . + {"message": "dxagent name is required", "statusCode": 404}'
    exit 1
fi
if [[ -z "$GCHILD" ]] ; then
    ./jq -n ' . + {"message": "access control dxc name is required", "statusCode": 404}'
    exit 1
fi
    bash "${DIRNAME}/coreZ010101/delete.sh" "${NAME}" "${CHILD}" "${GCHILD}"
