#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
NAME=$1
if [[ -z "${NAME}" ]]; then
   bash "${MYPATH}/coreZ0/get.sh"
else
   bash "${MYPATH}/coreZ01/get.sh" "$NAME"
fi
