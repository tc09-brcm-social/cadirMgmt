#!/bin/bash
. ./authn
QUERY=$1
ADDL=$2
if [[ ! -z "$QUERY" ]] ; then
   QUERY=?"$QUERY"
fi
if [[ -z "${ADDL}" ]] ; then
   ADDL="--header,Accept: application/json,--header,Content-Type: application/json"
fi
IFS=',' read -r -a array <<< "$ADDL"
curl ${OPT} -s -k -H "$AUTHN" \
   -X POST \
   "${array[@]}" \
   "https://${RESTHOST}:${RESTPORT}/ca/api/dxmanagement/v0.1/../../../../file/file_upload${QUERY}"
