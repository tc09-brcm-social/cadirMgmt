#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
NAME=$1
if [[ -z "${NAME}" ]]; then
    ./jq -n '{"message": "Environment name is required", "statusCode": 404}'
    exit
else
   bash "${MYPATH}/coreZ01/delete.sh" "$NAME"
fi
