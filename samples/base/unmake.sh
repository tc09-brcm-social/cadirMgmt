#!/bin/bash
. ../env.shlib
. ./env.shlib
MYPWD=$(pwd)
cd ../..
#
# default Data DSA
#
VER=$(bash dxagents/about.sh "$ENVNAME" "$DXAGENT" | \
      jq -r '.version' | awk '{print $2}')
DSA=default.${VER}${TEST}
if EXIST=$(bash dsas/exist.sh "$ENVNAME" "$DXAGENT" "$DSA"); then
    >&2 echo "DSA $DSA of $DXAGENT under environment $ENVNAME exists, removing ..."
    bash dsas/delete.sh "$ENVNAME" "$DXAGENT" "$DSA"
else
    >&2 echo "DSA $DSA of $DXAGENT under environment $ENVNAME does not exists, skipped"
fi
#
# default Router DSA
#
DSA=defrouter.${VER}${TEST}
if EXIST=$(bash dsas/exist.sh "$ENVNAME" "$DXAGENT" "$DSA"); then
    >&2 echo "DSA $DSA of $DXAGENT under environment $ENVNAME exists, removing ..."
    bash dsas/delete.sh "$ENVNAME" "$DXAGENT" "$DSA"
else
    >&2 echo "DSA $DSA of $DXAGENT under environment $ENVNAME does not exists, skipped"
fi
#
# DXAGENT
#
if EXIST=$(bash dxagents/exist.sh "$ENVNAME" "$DXAGENT"); then
    >&2 echo "dxagent $DXAGENT under environment $ENVNAME exists, removing ..."
    bash dxagents/delete.sh "$ENVNAME" "$DXAGENT"
else
    >&2 echo "dxagent $DXAGENT under environment $ENVNAME does not exist, skipped"
fi
#
# Environment
#
if EXIST=$(bash environments/exist.sh "$ENVNAME"); then
    >&2 echo "Environment $ENVNAME exists, removing ..."
    bash environments/delete.sh "$ENVNAME"
else
    >&2 echo "Environment $ENVNAME does not exist, skipped"
fi
