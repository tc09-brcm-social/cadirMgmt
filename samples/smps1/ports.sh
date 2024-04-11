#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
cd ../..
. "$MYPATH"/env.shlib
DSAports() {
    local _envname=$1
    local _dxaname=$2
    local _dsaname=$3
    EXIST=$(bash dsas/exist.sh "$_envname" "$_dxaname" "$_dsaname"); STATUS=$?
    if [ "$STATUS" -ne 0 ] ; then
        >&2 echo "DSA $_dsaname does not exist under $_envname/$_dxaname, skipped ..."
    else
       echo "$EXIST" | bash dsas/ext/jports.sh
    fi
    }

DSAports "$ENVNAME" "$DXANAME" "$ROUTERNAME"
#DSAports "$ENVNAME" "$DXANAME" "$SMSSNAME"
#DSAports "$ENVNAME" "$DXANAME" "$SMPSNAME"
#DSAports "$ENVNAME" "$DXANAME" "$DATANAME"
