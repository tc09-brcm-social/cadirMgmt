#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
DXANAME=$1
cd ../..
. "$MYPATH"/../env.shlib
#
# procedure registrarDXACheck: Registrar Environment and DXAGENTS Verification
#
registrarDXACheck() {
    local _envname=${REGISTRARENV}
    local _dxaname=$1
    local EXIST=$(bash environments/exist.sh "$_envname"); STATUS=$?
    if [ $STATUS -ne 0 ]; then
        >&2 echo "Registrar environment $_envname does not exist."
        >&2 echo "To create it, go to execute the samples/registrar first"
        exit $STATUS
    fi
    >&2 echo "Registrar environment $_envname verified."
    DXAJSON=$(bash dxagents/exist.sh "$_envname" "$_dxaname"); STATUS=$?
    if [ $STATUS -ne 0 ]; then
        >&2 echo "Base DXAGENT $_dxaname does not exist in Registrar environment"
        >&2 echo "To create it, go to execute the samples/registrar first"
        >&2 echo "The following is a list of existing DXAGENTs"
	>&2 bash dxagents/list.sh "$_envname"
        exit $STATUS
    fi
    >&2 echo "Registrar DXAGENT $_dxaname verified."
    }

if [[ -z "$DXANAME" ]] ; then
    >&2 echo dxagent name is required
    exit 1
else
    registrarDXACheck "$DXANAME"
    echo "$DXAJSON" | bash dxagents/cleanse.sh
fi
