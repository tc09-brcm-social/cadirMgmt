#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
cd ../..
. "$MYPATH"/env.shlib
#
# procedure loadSchemas -- upload SiteMinder Schemas
#
loadSchemas() {
    local _envname=$1
    local _dxaname=$2
    if ! EXIST=$(bash schemas/exist.sh "$_envname" "$_dxaname" "etrust.dxc"); then
        JSON=$$.json
        EXIST=$(bash schemas/dxccreate.sh "$_envname" "$_dxaname" etrust.dxc \
            "${MYPATH}/etrust.dxc")
    fi
    echo "$EXIST" | ./jq '.'
    if ! EXIST=$(bash schemas/exist.sh "$_envname" "$_dxaname" "netegrity.dxc"); then
        JSON=$$.json
        EXIST=$(bash schemas/dxccreate.sh "$_envname" "$_dxaname" netegrity.dxc \
            "${MYPATH}/netegrity.dxc")
    fi
    echo "$EXIST" | ./jq '.'
    }
#
# load schemas
#
bash schemas/list.sh "$ENVNAME" "$DXANAME"
loadSchemas "$ENVNAME" "$DXANAME"
bash schemas/list.sh "$ENVNAME" "$DXANAME"
