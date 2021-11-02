#!/bin/bash
. ./authn
NAME=$1
CHILD=$2
QUERY=$3
ADDL=$4
if [[ ! -z "$QUERY" ]] ; then
   QUERY=?"$QUERY"
fi
if [[ -z "${ADDL}" ]] ; then
   ADDL="--header,Accept: application/json"
fi
IFS=',' read -r -a array <<< "$ADDL"
curl ${OPT} -s -k -H "$AUTHN" \
   -X GET \
   "${array[@]}" \
   "https://${RESTHOST}:${RESTPORT}/ca/api/dxmanagement/v0.1/environments/${NAME}/scim-instances/${CHILD}${QUERY}"
