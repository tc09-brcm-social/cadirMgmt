#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
ENVNAME=$1
JSON=$2
if [[ -z "${ENVNAME}" ]]; then
    ./jq -n ' . + {"message": "Environment name is required", "statusCode": 404}'
    exit 1
fi
if [[ -z "$JSON" ]] ; then
    >&2 echo "JSON formatted payload file required"
    exit 1
fi
ADDL="--header,Content-Type: application/json,--header,Accept: application/json,-d,@$JSON"
bash "${MYPATH}/coreZ010/post.sh" "$ENVNAME" "" "$ADDL"
