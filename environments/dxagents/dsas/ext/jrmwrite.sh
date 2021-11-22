#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
DSA=$1
EXIST=$(cat)
WRITE=$(echo "$EXIST" | \
      ./jq --arg a "$DSA" \
          'select (.config.settings."write-precedence" != null) |
           [ .config.settings."write-precedence"[] | select(. != $a) ]')
LEN=$(echo "$WRITE" | ./jq 'length')
if [[ -z "$WRITE" || "$LEN" -eq 0 ]] ; then
    echo "$EXIST" | \
        ./jq \
             'del(.config.settings."write-precedence")'
else
    echo "$EXIST" | \
        ./jq --argjson w "$WRITE" \
             '.config.settings."write-precedence" = $w'
fi
