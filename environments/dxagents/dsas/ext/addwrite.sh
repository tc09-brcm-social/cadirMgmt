#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
ENVNAME=$1
DXA1=$2
DSA1=$3
DXA2=$4
DSA2=$5
EXIST=$(bash "${MYPATH}/../exist.sh" "$ENVNAME" "$DXA2" "$DSA2"); STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo "$EXIST"
    exit "$STATUS"
fi
EXIST=$(bash "${MYPATH}/../exist.sh" "$ENVNAME" "$DXA1" "$DSA1"); STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo "$EXIST"
    exit "$STATUS"
fi
#
# add Write Precedence DSA2 to DSA1
#
JSON=$$.json
echo "$EXIST" | bash "${MYPATH}/../cleanse.sh" \
    | bash "${MYPATH}/jaddwrite.sh" "$DSA2" > "$JSON" ; STATUS=$?
if [ "$STATUS" -eq 0 ] ; then
    bash "${MYPATH}/../update.sh" "$ENVNAME" "$DXA1" "$DSA1" "$JSON"
else
    echo "$EXIST"
fi
