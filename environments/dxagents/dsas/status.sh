#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
ENV=$1
DXA=$2
NAME=$3
EXIST=$(bash "${MYPATH}/exist.sh" "$ENV" "$DXA" "$NAME" "name,status"); STATUS=$?
echo "$EXIST"
if [ "$STATUS" -ne 0 ] ; then
   exit "$STATUS"
fi
