#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
cd ../..
HOMEDIR=$(pwd)
. "$MYPATH"/env.shlib
EXIST=$(bash dxagents/exist.sh "$ENVNAME" "$DXANAME"); STATUS=$?
if [ "$STATUS" -ne 0 ] ; then
    >&2 echo "DXAGENT $DXANAME under environment $ENVNAME does not exist, failed"
    exit 1
fi
if [ -z "$LDAPHOST" ]; then
    LDAPHOST=$(echo "$EXIST" | ./jq -r .host)
fi
#
## makeDSA using a JSON payload and dsas/jmaketemp2.sh as template
#
makeDSA() {
    local _envname=$1
    local _dxaname=$2
    local _dsaname=$3
    local _json=$4
    local _host=$5
    local _port=$6

    EXIST=$(bash dsas/exist.sh "$_envname" "$_dxaname" "$_dsaname"); STATUS=$?
    if [ "$STATUS" -eq 0 ] ; then
        >&2 echo "DSA $_dsaname exits under $_envname/$_dxaname, skipped ..."
    else
        >&2 echo "Making DSA $_dsaname under $_envname/$_dxaname ..."
        JSON=$$.json
        TMPL=$$.temp
        echo "$_json" | bash dsas/jmaketemp2.sh > "$TMPL"
        bash "$TMPL" "$_dsaname" "$_host" "$_port" > "$JSON"
        EXIST=$(bash dsas/create.sh "$_envname" "$_dxaname" "$JSON")
    fi
    echo "$EXIST" | bash dsas/cleanse.sh
    }
#
## Router
#
cd "$MYPATH/${ROUTERJSONDIR}"
ROUTERJSON=$(bash make.sh "$DXANAME")
cd "$HOMEDIR"
ROUTERJSON=$(echo "$ROUTERJSON" | ./jq --argjson a "$ROUTERSCHEMA" \
    '.config.schema = $a')
makeDSA "$ENVNAME" "$DXANAME" "$ROUTERNAME" \
    "$ROUTERJSON" "$LDAPHOST" "$ROUTERPORT"
#
## User
#
git checkout "$MYPATH/${DATAJSONDIR}/env.shlib"
if [ ! -z "$DATAPREFIX" ] ; then
    x=$(bash utils/setkeyvalue.sh "$MYPATH/${DATAJSONDIR}/env.shlib" \
        PREFIX "$DATAPREFIX")
fi
if [ ! -z "$DATADBSIZE" ] ; then
    x=$(bash utils/setkeyvalue.sh "$MYPATH/${DATAJSONDIR}/env.shlib" \
        DBSIZE "$DATADBSIZE")
fi
cd "$MYPATH/${DATAJSONDIR}"
USERJSON=$(bash make.sh "$DXANAME")
cd "$HOMEDIR"
makeDSA "$ENVNAME" "$DXANAME" "$DATANAME" \
    "$USERJSON" "$LDAPHOST" "$DATAPORT"
#
## Add to Router
#
bash dsas/ext/addpeers.sh "$ENVNAME" "$DXANAME" "$ROUTERNAME" "$DXANAME" "$DATANAME" | \
    ./jq '{ "name": .name, "status": .status, "dsaPeers": .dsaPeers}'
#
## Load LDIF
#
loadLDIF() {
    local _envname=$1
    local _dxaname=$2
    local _dsaname=$3
    local _ldiftemp=$4
    local _prefix=$5
    local _password=$6

    bash dsas/emptydb.sh "$_envname" "$_dxaname" "$_dsaname"
    LDIF=$$.ldif
    bash "$_ldiftemp" "$_prefix" "$_password" > "$LDIF"
    EXIST=$(bash file/file_upload.sh "$LDIF"); STATUS=$?
    if [ "$STATUS" -eq 0 ] ; then
        FNAME=$(echo "$EXIST" | ./jq -r '.filename')
        JSON=$$.json
        bash dsas/ldif/temp/simple.temp "$FNAME" > "$JSON"
        bash dsas/ldif/load.sh "$_envname" "$_dxaname" "$_dsaname" "$JSON"
    fi
    }

loadLDIF "$ENVNAME" "$DXANAME" "$DATANAME" \
    "$MYPATH"/"$DATALDIFTEMP" "$DATAPREFIX" "$DATAPASS"
#
## SMPS
#
git checkout "$MYPATH/${SMPSJSONDIR}/env.shlib"
if [ ! -z "$SMPSPREFIX" ] ; then
    x=$(bash utils/setkeyvalue.sh "$MYPATH/${SMPSJSONDIR}/env.shlib" \
        PREFIX "$SMPSPREFIX")
fi
if [ ! -z "$SMPSDBSIZE" ] ; then
    x=$(bash utils/setkeyvalue.sh "$MYPATH/${SMPSJSONDIR}/env.shlib" \
        DBSIZE "$SMPSDBSIZE")
fi
cd "$MYPATH/${SMPSJSONDIR}"
SMPSJSON=$(bash make.sh "$DXANAME")
cd "$HOMEDIR"
makeDSA "$ENVNAME" "$DXANAME" "$SMPSNAME" \
    "$SMPSJSON" "$LDAPHOST" "$SMPSPORT"
bash dsas/ext/addpeers.sh "$ENVNAME" "$DXANAME" "$ROUTERNAME" "$DXANAME" "$SMPSNAME" | \
    ./jq '{ "name": .name, "status": .status, "dsaPeers": .dsaPeers}'
loadLDIF "$ENVNAME" "$DXANAME" "$SMPSNAME" \
    "$MYPATH"/"$SMPSLDIFTEMP" "$SMPSPREFIX" "$SMPSPASS"
#
## SMSS
#
git checkout "$MYPATH/${SMSSJSONDIR}/env.shlib"
if [ ! -z "$SMSSPREFIX" ] ; then
    x=$(bash utils/setkeyvalue.sh "$MYPATH/${SMSSJSONDIR}/env.shlib" \
        PREFIX "$SMSSPREFIX")
fi
if [ ! -z "$SMSSDBSIZE" ] ; then
    x=$(bash utils/setkeyvalue.sh "$MYPATH/${SMSSJSONDIR}/env.shlib" \
        DBSIZE "$SMSSDBSIZE")
fi
cd "$MYPATH/${SMSSJSONDIR}"
SMSSJSON=$(bash make.sh "$DXANAME")
cd "$HOMEDIR"
makeDSA "$ENVNAME" "$DXANAME" "$SMSSNAME" \
    "$SMSSJSON" "$LDAPHOST" "$SMSSPORT"
bash dsas/ext/addpeers.sh "$ENVNAME" "$DXANAME" "$ROUTERNAME" "$DXANAME" "$SMSSNAME" | \
    ./jq '{ "name": .name, "status": .status, "dsaPeers": .dsaPeers}'
loadLDIF "$ENVNAME" "$DXANAME" "$SMSSNAME" \
    "$MYPATH"/"$SMSSLDIFTEMP" "$SMSSPREFIX" "$SMSSPASS"
