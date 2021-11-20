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
## Router
#
NAME=$ROUTERNAME
EXIST=$(bash dsas/exist.sh "$ENVNAME" "$DXANAME" "$NAME"); STATUS=$?
if [ "$STATUS" -eq 0 ] ; then
    >&2 echo "DSA $NAME exits under $ENVNAME/$DXANAME, skipped ..."
else
    cd "$MYPATH/${ROUTERJSONDIR}"
    ROUTERJSON=$(bash make.sh)
    cd "$HOMEDIR"
    TMPL=$$.temp
    echo "$ROUTERJSON" | bash dsas/jmaketemp2.sh > "$TMPL"
    LDAPPORT=$ROUTERPORT
    >&2 echo "Making DSA $NAME under $ENVNAME/$DXANAME ..."
    JSON=$$.json
    bash "$TMPL" "$NAME" "$LDAPHOST" "$LDAPPORT" > "$JSON"
    EXIST=$(bash dsas/create.sh "$ENVNAME" "$DXANAME" "$JSON")
fi
echo "$EXIST" | bash dsas/cleanse.sh
#
## User
#
NAME=$DATANAME
EXIST=$(bash dsas/exist.sh "$ENVNAME" "$DXANAME" "$NAME"); STATUS=$?
if [ "$STATUS" -eq 0 ] ; then
    >&2 echo "DSA $NAME exits under $ENVNAME/$DXANAME, skipped ..."
else
    git checkout "$MYPATH/${DATAJSONDIR}/env.shlib"
    x=$(bash utils/setkeyifvalue.sh "$MYPATH/${DATAJSONDIR}/env.shlib" \
        PREFIX "$DATAPREFIX")
    x=$(bash utils/setkeyifvalue.sh "$MYPATH/${DATAJSONDIR}/env.shlib" \
        DBSIZE "$DATADBSIZE")
    cd "$MYPATH/${DATAJSONDIR}"
    USERJSON=$(bash make.sh)
    cd "$HOMEDIR"
    TMPL=$$.temp
    echo "$USERJSON" |  bash dsas/jmaketemp2.sh > "$TMPL"
    LDAPPORT=$DATAPORT
    >&2 echo "Making DSA $NAME under $ENVNAME/$DXANAME ..."
    JSON=$$.json
    bash "$TMPL" "$NAME" "$LDAPHOST" "$LDAPPORT" > "$JSON"
    EXIST=$(bash dsas/create.sh "$ENVNAME" "$DXANAME" "$JSON")
fi
echo "$EXIST" | bash dsas/cleanse.sh
#
## addpeers between Router and DATA DSAs
#
bash dsas/ext/addpeers.sh "$ENVNAME" "$DXANAME" "$ROUTERNAME" \
    "$DXANAME" "$DATANAME" | bash dsas/ext/jshowpeers.sh
#
## Load LDIF to Data
#
NAME=$DATANAME
LDIFTEMP=$DATALDIFTEMP
PREFIX=$DATAPREFIX
PASS=$DATAPASS
bash dsas/emptydb.sh "$ENVNAME" "$DXANAME" "$NAME"
LDIF=$$.ldif
bash "$MYPATH"/"$LDIFTEMP" "$PREFIX" "$PASS" > "$LDIF"
EXIST=$(bash file/file_upload.sh "$LDIF"); STATUS=$?
if [ "$STATUS" -eq 0 ] ; then
    FNAME=$(echo "$EXIST" | ./jq -r '.filename')
    JSON=$$.json
    bash dsas/ldif/temp/simple.temp "$FNAME" > "$JSON"
    bash dsas/ldif/load.sh "$ENVNAME" "$DXANAME" "$NAME" "$JSON"
else
    >&2 echo "$EXIST"
    >&2 echo file_upload $LDIF failed ...
fi
#
## Start both DSAs
#
bash dsas/status/start.sh "$ENVNAME" "$DXANAME" "$NAME"
NAME=$ROUTERNAME
bash dsas/status/start.sh "$ENVNAME" "$DXANAME" "$NAME"
