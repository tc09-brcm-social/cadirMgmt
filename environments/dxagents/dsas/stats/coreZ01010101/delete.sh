#!/bin/bash
. ./authn
NAME=$1
CHILD=$2
GCHILD=$3
G4CHILD=$4
QUERY=$5
ADDL=$6
if [[ ! -z "$QUERY" ]] ; then
   QUERY=?"$QUERY"
fi
if [[ -z "${ADDL}" ]] ; then
   ADDL="--header,Accept: application/json"
fi
IFS=',' read -r -a array <<< "$ADDL"
curl ${OPT} -s -k -H "$AUTHN" \
   -X DELETE \
   "${array[@]}" \
   "https://${RESTHOST}:${RESTPORT}/ca/api/dxmanagement/v0.1/environments/${NAME}/dxagents/${CHILD}/dsas/${GCHILD}/dsas/${G4CHILD}${QUERY}"
