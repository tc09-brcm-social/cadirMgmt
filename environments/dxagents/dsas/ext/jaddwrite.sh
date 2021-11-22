#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
DSA=$1
EXIST=$(cat)
if [ -z "$DSA" ] ; then
    >&2 echo "$0 DSAName : Require a DSA name, failed"
    echo "$EXIST"
    exit 1
fi
LEN=$(echo "$EXIST" | \
      ./jq --arg a "$DSA" \
          'select (.config.settings."write-precedence" != null) |
           [ .config.settings."write-precedence"[] | select(. == $a) ] |
           length' )
if [[ -z "$LEN" || "$LEN" -eq "0" ]] ; then
    echo "$EXIST" | \
        ./jq --arg a "$DSA" \
             '.config.settings."write-precedence" += [$a]'
else
    >&2 echo "$DSA exists in the \"write-precedence\" list already, failed"
    echo "$EXIST"
    exit 1
fi
