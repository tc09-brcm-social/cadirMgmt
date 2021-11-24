#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
cd ../..
. "$MYPATH"/env.shlib
statusDSA() {
    local _envname=$1
    local _dxaname=$2
    local _dsaname=$3
    EXIST=$(bash dsas/exist.sh "$_envname" "$_dxaname" "$_dsaname"); STATUS=$?
    if [ "$STATUS" -ne 0 ] ; then
        >&2 echo "DSA $_dsaname does not exist under $_envname/$_dxaname, skipped ..."
        echo "{\"name\":\"$_dsaname\",\"status\":\"nonexistent\" }"
    else
        >&2 echo "Checking DSA $_dsaname exists under $_envname/$_dxaname, ..."
        bash dsas/status.sh "$_envname" "$_dxaname" "$_dsaname"
    fi
    }

appList() {
    local _list=$1
    local _item=$2
    _list=$(echo "$_list" | ./jq -c --argjson a "$_item" '. += $a')
    echo "$_list"
    }
LIST="[]"
LIST=$(appList "$LIST" "[$(statusDSA "$ENVNAME" "$DXANAME" "$ROUTERNAME")]")
LIST=$(appList "$LIST" "[$(statusDSA "$ENVNAME" "$DXANAME" "$SMSSNAME")]")
LIST=$(appList "$LIST" "[$(statusDSA "$ENVNAME" "$DXANAME" "$SMPSNAME")]")
LIST=$(appList "$LIST" "[$(statusDSA "$ENVNAME" "$DXANAME" "$DATANAME")]")
echo "$LIST"
