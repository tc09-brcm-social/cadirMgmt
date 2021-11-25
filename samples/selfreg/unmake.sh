#!/bin/bash
MYPATH=$(cd $(dirname "0"); pwd)
. "${MYPATH}"/../env.shlib
. "${MYPATH}"/env.shlib
cd ../..
#
## Environment check
#
ENVNAME=$REGISTRARENV${TEST}
if ! EXIST=$(bash environments/exist.sh "$ENVNAME"); then
    echo "$EXIST" | >&2 ./jq '.'
    >&2 echo "Environment "$ENVNAME" does not exist, exiting ..."
    exit
fi
#
## Version
#
DXAGENT=$NAME
VER=$(bash dxagents/about.sh "$ENVNAME" "$DXAGENT" | \
      jq -r '.version' | awk '{print $2}')
#
## default Router DSA
#
DSA=defrouter.${VER}${TEST}
if EXIST=$(bash dsas/exist.sh "$ENVNAME" "$DXAGENT" "$DSA"); then
    >&2 echo "Removing DSA $DSA of $DXAGENT under environment $ENVNAME ..."
    bash dsas/delete.sh "$ENVNAME" "$DXAGENT" "$DSA"
else
    >&2 echo "DSA $DSA of $DXAGENT under environment $ENVNAME does not exists, skipped"
fi
#
## default Data DSA
#
DSA=default.${VER}${TEST}
if EXIST=$(bash dsas/exist.sh "$ENVNAME" "$DXAGENT" "$DSA"); then
    >&2 echo "Removing DSA $DSA of $DXAGENT under environment $ENVNAME ..."
    bash dsas/delete.sh "$ENVNAME" "$DXAGENT" "$DSA" "" 1 ""
else
    >&2 echo "DSA $DSA of $DXAGENT under environment $ENVNAME does not exists, skipped"
fi
#
## DXAGENT
#
if ! EXIST=$(bash dxagents/exist.sh "$ENVNAME" "$DXAGENT"); then
    echo "$EXIST" | >&2 ./jq '.'
    >&2 echo "$DXAGENT under $ENVNAME does not exit, skipped ..."
else
    >&2 echo "Removing $DXAGENT under $ENVNAME ..."
    bash dxagents/delete.sh "$ENVNAME" "$DXAGENT"
fi
#
## Enbironment
#
LIST=$(bash dxagents/list.sh "$ENVNAME")
if [ $(echo "$LIST" | ./jq 'length') -eq 0 ] ; then
    >&2 echo "The number of dxagent under $ENVNAME is now 0"
    >&2 echo "Removing environment $ENVNAME ..."
    bash environments/delete.sh "$ENVNAME"
else
    echo "Remaining dxagents under $ENVNAME:"
    echo "$LIST" | ./jq '.'
fi
