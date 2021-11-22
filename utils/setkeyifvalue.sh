#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
FILE=$1
KEY=$2
VALUE=$3
if [[ -z "$FILE" ]] ; then
    >&2 echo "FILE name is required"
    exit 1
fi
if [[ -z "$KEY" ]] ; then
    >&2 echo "KEY name is required"
    exit 1
fi
if [[ ! -z "$VALUE" ]] ; then
    bash "$MYPATH/setkeyvalue.sh" "$FILE" "$KEY" "$VALUE"
fi
