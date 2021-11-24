#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
cd ../..
. "$MYPATH"/env.shlib
rmDSA() {
    local _envname=$1
    local _dxaname=$2
    local _dsaname=$3
    EXIST=$(bash dsas/exist.sh "$_envname" "$_dxaname" "$_dsaname"); STATUS=$?
    if [ "$STATUS" -ne 0 ] ; then
        >&2 echo "DSA $_dsaname does not exist under $_envname/$_dxaname, skipped ..."
    else
        >&2 echo "Removing DSA $_dsaname exists under $_envname/$_dxaname, ..."
        bash dsas/delete.sh "$_envname" "$_dxaname" "$_dsaname" "" 1 ""
    fi
    }

# remove router first would avoid having remove write-precedence first
rmDSA "$ENVNAME" "$DXANAME" "$ROUTERNAME"
rmDSA "$ENVNAME" "$DXANAME" "$SMSSNAME"
rmDSA "$ENVNAME" "$DXANAME" "$SMPSNAME"
rmDSA "$ENVNAME" "$DXANAME" "$DATANAME"
