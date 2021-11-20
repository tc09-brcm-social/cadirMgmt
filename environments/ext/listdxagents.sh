#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
OUTPUT="[]"
LIST=$(bash "$MYPATH/../list.sh")
LEN=$(echo "$LIST" | ./jq 'length')
for (( i = 0; i < $LEN ; ++i )) ; do
    ENV=$(echo "$LIST" | ./jq -r ".[$i]")
    DXAs=$(bash "$MYPATH/../dxagents/list.sh" "$ENV")
    OUTPUT=$(echo "$OUTPUT" | ./jq --arg x "$ENV" --argjson s "$DXAs" \
        '. += [ { "environment": $x, "dxagents": $s } ]')
done
echo "$OUTPUT" | ./jq '.'
