#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
NAME=$1
CHILD=$2
GCHILD=$3
if [[ -z "${NAME}" ]]; then
    ./jq -n ' . + {"message": "Environment name is required", "statusCode": 404}'
    exit
fi
if [[ -z "${CHILD}" ]]; then
    ./jq -n ' . + {"message": "dxagent name is required", "statusCode": 404}'
    exit
else
	AGENT="/${CHILD}"
fi
if [[ -z "${GCHILD}" ]]; then
    ./jq -n ' . + {"message": "DSA name is required", "statusCode": 404}'
    exit
else
    OBJ="/${GCHILD}"
fi
JSON=$$.json
DATA='{ "peerDsa": "'${GCHILD}'" }'
ADDL="--header,Accept: application/json,--header,Content-Type: application/json,-d,$DATA"
bash "${DIRNAME}/coreZ010100/post.sh" "$NAME" "$CHILD" "" "$ADDL"
