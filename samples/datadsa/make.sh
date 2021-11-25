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
EXIST=$(bash dsas/exist.sh "$ENVNAME" "$DXANAME" "$NAME"); STATUS=$?
if [ "$STATUS" -eq 0 ] ; then
    >&2 echo "DSA $NAME exits under $ENVNAME/$DXANAME, skipped ..."
    exit
fi
cd "$MYPATH/${JSONDIR}"
JSON=$(bash make.sh "$DXANAME")
cd "$HOMEDIR"
TMPL=$$.temp
if [ -z "$DBSIZE" ] ; then
  DBSIZE=$(echo "$JSON" | ./jq -r '.config.server."dxgrid-db-size"')
fi
echo "$JSON" | bash dsas/cleanse.sh | \
    ./jq -S ".config.knowledge[0].prefix = \"${PREFIX}\""'
      | .config.server."dxgrid-db-size" = '"$DBSIZE"'
      ' | \
    bash dsas/jmaketemp2.sh > "$TMPL"
JSON=$$.json
bash "$TMPL" "$NAME" "$LDAPHOST" "$PORT" > "$JSON"
bash dsas/create.sh "$ENVNAME" "$DXANAME" "$JSON"
