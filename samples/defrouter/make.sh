#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
DXANAME=$1
if [ -z "$DXANAME" ] ; then
    >&2 echo "Usage: $0 DXANAME -- DXANAME required"
    exit 1
fi
. "${MYPATH}"/../env.shlib
. "${MYPATH}"/env.shlib
cd ../..
ENVNAME=$REGISTRARENV$TEST
VER=$(bash dxagents/about.sh "$ENVNAME" "$DXANAME" | \
      jq -r '.version' | awk '{print $2}')
DSA=defrouter.${VER}${TEST}
EXIST=$(bash dsas/exist.sh "$ENVNAME" "$DXANAME" "$DSA"); STATUS=$?
if [ "$STATUS" -ne 0 ] ; then
    >&2 echo default router DSA retrieval from "$ENVNAME" "$DXANAME" failed ...
    exit 1
fi
echo "$EXIST" | bash "dsas/cleanse.sh"
