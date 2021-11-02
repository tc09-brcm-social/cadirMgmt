#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
ENVNAME=$1
DXANAME=$2
NAME=$3
DXC=$4
if [[ -z "${ENVNAME}" ]]; then
    ./jq -n ' . + {"message": "Environment name is required", "statusCode": 404}'
    exit 1
fi
if [[ -z "${DXANAME}" ]]; then
    ./jq -n ' . + {"message": "dxagent name is required", "statusCode": 404}'
    exit 1
fi
if [[ -z "${NAME}" ]]; then
    ./jq -n ' . + {"message": "access control name is required", "statusCode": 404}'
    exit 1
fi
if [[ -z "$DXC" ]]; then
    ./jq -n ' . + {"message": "DXC file name is required", "statusCode": 404}'
    exit 1
fi
JSON=$$.$NAME.json
bash "${MYPATH}/temp/dxc2json.temp" "$NAME" "$DXC" > "$JSON"
bash "${MYPATH}/update.sh" "$ENVNAME" "$DXANAME" "$NAME" "$JSON"
