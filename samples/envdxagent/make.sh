#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
. "$MYPATH"/env.shlib
cd ../..
HOMEDIR=$(pwd)
#
# Environment
#
if ! EXIST=$(bash environments/exist.sh "$ENVNAME"); then
    JSON=$$.json
    bash environments/temp/simple.temp "$ENVNAME" >$JSON
    EXIST=$(bash environments/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.'
#
# DXAGENT
#
DXAGENT=$DXANAME
if ! EXIST=$(bash dxagents/exist.sh "$ENVNAME" "$DXAGENT"); then
    cd "${MYPATH}/${DXADIR}" 
    DXAJSON=$(bash make.sh "$DXAGENT"); STATUS=$?
    if [ "$STATUS" -ne 0 ] ; then
        >&2 echo "$DXAGENT" has not been registered under registrar environment. failed ...
        exit "$STATUS"
    fi
    cd "$HOMEDIR"
    TMPL=$$.temp
    echo "$DXAJSON" | bash dxagents/jmaketemp.sh > "$TMPL"
    JSON=$$.json
    bash "$TMPL" "$DXAGENT" > "$JSON"
    EXIST=$(bash dxagents/create.sh "$ENVNAME" "$JSON")
fi
echo "$EXIST" | bash dxagents/cleanse.sh
