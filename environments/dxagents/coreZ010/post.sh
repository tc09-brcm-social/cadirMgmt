#!/bin/bash
. ./authn
NAME=$1
QUERY=$2
ADDL=$3
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
   "https://${RESTHOST}:${RESTPORT}/ca/api/dxmanagement/v0.1/environments/${NAME}/dxagents${QUERY}"
