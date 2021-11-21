#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
cd ../..
HOMEDIR=$(pwd)
. "$MYPATH"/env.shlib
EXIST=$(bash dxagents/exist.sh "$ENVNAME" "$DXANAME"); STATUS=$?
if [ "$STATUS" -ne 0 ] ; then
    >&2 echo "Creating DXAGENT $DXANAME under environment $ENVNAME ..."
    git checkout "$MYPATH/${ENVDXAGENTDIR}/env.shlib"
    x=$(bash utils/setkeyvalue.sh "$MYPATH/${ENVDXAGENTDIR}/env.shlib" \
        ENVNAME "$ENVNAME")
    x=$(bash utils/setkeyvalue.sh "$MYPATH/${ENVDXAGENTDIR}/env.shlib" \
        DXANAME "$DXANAME")
    cd "$MYPATH/${ENVDXAGENTDIR}"
    bash make.sh
    cd "$HOMEDIR"
    EXIST=$(bash dxagents/exist.sh "$ENVNAME" "$DXANAME"); STATUS=$?
fi
echo "$EXIST" | bash dxagents/cleanse.sh
