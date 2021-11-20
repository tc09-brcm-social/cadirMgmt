#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
cd ../..
. "$MYPATH"/env.shlib
EXIST=$(bash dsas/exist.sh "$ENVNAME" "$DXANAME" "$NAME"); STATUS=$?
if [ "$STATUS" -ne 0 ] ; then
    >&2 echo "DSA $NAME does not exist under $ENVNAME/$DXANAME, skipped ..."
    exit
fi
>&2 echo "Removing DSA $NAME exist under $ENVNAME/$DXANAME, ..."
bash dsas/delete.sh "$ENVNAME" "$DXANAME" "$NAME" "" 1 ""
