#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
NAME=$1
CHILD=$2
GCHILD=$3
bash "$DIRNAME"/../backup/trigger.sh "$NAME" "$CHILD" "$GCHILD"
