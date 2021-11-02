#!/bin/bash
NAME=$1
CHILD=$2
MYPATH=$(cd $(dirname "$0"); pwd)
EXIST=$(bash ${MYPATH}/exist.sh "$NAME" "$CHILD");STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo "$EXIST"
    exit "$STATUS"
fi
echo "$EXIST" | bash "${MYPATH}/jmaketemp.sh"
