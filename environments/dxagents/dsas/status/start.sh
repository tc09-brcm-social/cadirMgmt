#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
MYBASE=$(basename "$DIRNAME")
NAME=$1
CHILD=$2
GCHILD=$3
MYNAME=$(basename "$0" | cut -f1 -d.)
JSON=$$.json
./jq -n --arg s "$MYNAME" '{"action": $s}' > "$JSON"
bash "${DIRNAME}/update.sh" "$NAME" "$CHILD" "$GCHILD" "$JSON"
