#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
MYNAME=$(basename "$0" | cut -f1 -d.)
NAME=$1
CHILD=$2
GCHILD=$3
bash "${DIRNAME}/$MYNAME/trigger.sh" "$NAME" "$CHILD" "$GCHILD"
