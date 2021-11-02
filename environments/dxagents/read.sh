#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
ENVNAME=$1
CHILD=$2
ATTRS=$3
if [[ -z "${ENVNAME}" ]]; then
    ./jq -n ' . + {"message": "Environment name is required", "statusCode": 404}'
    exit
fi
if [[ ! -z "${ATTRS}" ]]; then
    ATTRS="attributes=${ATTRS}"
fi
if [[ -z "$CHILD" ]] ; then
    bash "${DIRNAME}/coreZ010/get.sh" "$ENVNAME" "$ATTRS"
else
    bash "${DIRNAME}/coreZ0101/get.sh" "$ENVNAME" "$CHILD" "$ATTRS"
fi
