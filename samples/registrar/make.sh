#!/bin/bash
MYPATH=$(cd $(dirname "0"); pwd)
. "${MYPATH}"/../env.shlib
. "${MYPATH}"/env.shlib
cd ../..
#
# Environment
#
ENVNAME=$REGISTRARENV${TEST}
if ! EXIST=$(bash environments/exist.sh "$ENVNAME"); then
    JSON=$$.json
    bash environments/temp/simple.temp "$ENVNAME" | \
        ./jq '. + { description: "Registrar Environment - do not edit"}' >$JSON
    EXIST=$(bash environments/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.'
DXAGENT=$NAME
if EXIST=$(bash dxagents/exist.sh "$ENVNAME" "$DXAGENT"); then
    >&2 echo "$DXAGENT exits, existing ..."
    echo "$EXIST" | bash dxagents/cleanse.sh
    exit
fi
SAVEAUTHN=authn.$$
cp authn "$SAVEAUTHN"
x=$(bash utils/setkeyvalue.sh "utils/env.shlib" "ADMINID" "$ADMINID")
x=$(bash utils/setkeyvalue.sh "utils/env.shlib" "ADMINPASS" "$ADMINPASS")
x=$(bash utils/setkeyvalue.sh "utils/env.shlib" "RESTHOST" "$HOST")
x=$(bash utils/setkeyvalue.sh "utils/env.shlib" "RESTPORT" "$PORT")
bash utils/makeauthn.sh
ENVNAME=$BASEENVNAME
if ! EXIST=$(bash environments/exist.sh "$ENVNAME"); then
    >&2 echo "Base Environment on host $HOST does not exist, quitting ..."
    >&2 echo "Run the samples/base on $HOST first."
    exit 1
fi
DXAGENT=$BASEDXAGENT
if ! EXIST=$(bash dxagents/exist.sh "$ENVNAME" "$DXAGENT"); then
    >&2 echo "Base DXAGENT on host $HOST does not exist, quitting ..."
    >&2 echo "Run the samples/base on $HOST first."
    exit 2
fi
TMPL=$$.temp
bash dxagents/maketemp.sh "$ENVNAME" "$DXAGENT" > "$TMPL"
cp authn "authn.$NAME"
cp "$SAVEAUTHN" authn
ENVNAME=$REGISTRARENV{$TEST}
DXAGENT=$NAME
if ! EXIST=$(bash dxagents/exist.sh "$ENVNAME" "$DXAGENT"); then
    JSON=$$.json
    bash "$TMPL" "$NAME" > "$JSON"
    EXIST=$(bash dxagents/create.sh "$ENVNAME" "$JSON")
fi
echo "$EXIST" | bash dxagents/cleanse.sh
rm "$SAVEAUTHN"
