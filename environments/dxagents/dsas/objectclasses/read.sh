#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
NAME=$1
CHILD=$2
GCHILD=$3
G2CHILD=$4
if [[ -z "${NAME}" ]]; then
    ./jq -n ' . + {"message": "Environment name is required", "statusCode": 404}'
    exit
fi
if [[ -z "${CHILD}" ]]; then
    ./jq -n ' . + {"message": "dxagent name is required", "statusCode": 404}'
    exit
fi
if [[ -z "${GCHILD}" ]]; then
    ./jq -n ' . + {"message": "dxagent name is required", "statusCode": 404}'
    exit
fi
if [[ -z "$G2CHILD" ]] ; then
    bash "${DIRNAME}/coreZ0101010/post.sh" "${NAME}" "${CHILD}" "${GCHILD}"
else
    bash "${DIRNAME}/coreZ01010101/post.sh" "${NAME}" "${CHILD}" "${GCHILD}" "${G2CHILD}"
fi
