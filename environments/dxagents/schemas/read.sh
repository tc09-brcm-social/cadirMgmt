#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
NAME=$1
CHILD=$2
GCHILD=$3
ATTR=$4
if [[ -z "${NAME}" ]]; then
    ./jq -n ' . + {"message": "Environment name is required", "statusCode": 404}'
    exit
fi
if [[ -z "${CHILD}" ]]; then
    ./jq -n ' . + {"message": "dxagent name is required", "statusCode": 404}'
    exit
fi
   if [[ -z "${ATTR}" ]]; then
      OPT=""
   else
      OPT="attributes=${ATTR}"
   fi
if [[ -z "$GCHILD" ]] ; then
    bash "${DIRNAME}/coreZ01010/get.sh" "${NAME}" "${CHILD}" "${OPT}"
else
    bash "${DIRNAME}/coreZ010101/get.sh" "${NAME}" "${CHILD}" "${GCHILD}" "${OPT}"
fi
