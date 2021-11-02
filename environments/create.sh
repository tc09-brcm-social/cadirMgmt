#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
JSON=$1
if [[ -z "$JSON" ]] ; then
    >&2 echo "JSON formatted payload file required"
    exit 1
fi
ADDL="--header,Content-Type: application/json,--header,Accept: application/json,-d,@$JSON"
bash "${MYPATH}/coreZ0/post.sh" "" "$ADDL"
