#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
cd ../..
. "$MYPATH"/env.shlib
startDSA() {
    local _envname=$1
    local _dxaname=$2
    local _dsaname=$3
    EXIST=$(bash dsas/exist.sh "$_envname" "$_dxaname" "$_dsaname"); STATUS=$?
    if [ "$STATUS" -ne 0 ] ; then
        >&2 echo "DSA $_dsaname does not exist under $_envname/$_dxaname, skipped ..."
    else
        >&2 echo "Starting DSA $_dsaname exists under $_envname/$_dxaname, ..."
        bash dsas/status/start.sh "$_envname" "$_dxaname" "$_dsaname"
    fi
    }

startDSA "$ENVNAME" "$DXANAME" "$ROUTERNAME"
startDSA "$ENVNAME" "$DXANAME" "$SMSSNAME"
startDSA "$ENVNAME" "$DXANAME" "$SMPSNAME"
startDSA "$ENVNAME" "$DXANAME" "$DATANAME"
