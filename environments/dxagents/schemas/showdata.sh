#!/bin/bash
ENVNAME=$1
NAME=$2
DXC=$3
MYPATH=`dirname $0`
bash "${MYPATH}/read.sh" "$ENVNAME" "$NAME" "$DXC" data | ./jq -r '.data' | base64 -d
