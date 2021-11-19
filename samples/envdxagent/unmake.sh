#!/bin/bash
MYPATH=$(cd $(dirname "0"); pwd)
. "${MYPATH}"/env.shlib
cd ../..
#
# Environment
#
if ! EXIST=$(bash environments/exist.sh "$ENVNAME"); then
    echo "$EXIST" | >&2 ./jq '.'
    >&2 echo "Environment "$ENVNAME" does not exist, exiting ..."
    exit
fi
DXAGENT=$DXANAME
if ! EXIST=$(bash dxagents/exist.sh "$ENVNAME" "$DXAGENT"); then
    echo "$EXIST" | >&2 ./jq '.'
    >&2 echo "$DXAGENT under $ENVNAME does not exit, skipped ..."
else
    >&2 echo "Removing $DXAGENT under $ENVNAME ..."
    bash dxagents/delete.sh "$ENVNAME" "$DXAGENT"
fi
LIST=$(bash dxagents/list.sh "$ENVNAME")
if [ $(echo "$LIST" | ./jq 'length') -eq 0 ] ; then
    >&2 echo "The number of dxagent under $ENVNAME is now 0"
    >&2 echo "Removing environment $ENVNAME ..."
    bash environments/delete.sh "$ENVNAME"
else
    >&2 echo "Remaining dxagents under $ENVNAME:"
    echo "$LIST" | >&2 ./jq '.'
fi
