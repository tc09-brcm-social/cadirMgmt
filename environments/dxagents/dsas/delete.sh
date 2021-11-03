#!/bin/bash
NAME=$1
CHILD=$2
GCHILD=$3
MYPATH=$(cd $(dirname "$0"); pwd)
EXIST=$(bash ${MYPATH}/exist.sh "$NAME" "$CHILD" "$GCHILD"); STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo "$EXIST"
    exit "$STATUS"
fi
bash "${MYPATH}/coreZ010101/delete.sh" "${NAME}" "${CHILD}" "${GCHILD}"
