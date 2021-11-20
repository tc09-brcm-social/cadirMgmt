#!/bin/bash
ENVNAME=$1
DXA1=$2
DSA1=$3
DXA2=$4
DSA2=$5
MYPATH=$(cd $(dirname "$0"); pwd)
DSA1JSON=$$.dsa1.json
bash "${MYPATH}/../exist.sh" "$ENVNAME" "$DXA1" "$DSA1" > "$DSA1JSON"
STATUS=$?
if [ $STATUS -ne 0 ]; then
    cat "$DSA1JSON"
    exit "$STATUS"
fi
DSA1K=$(cat "$DSA1JSON" | bash "${MYPATH}/jknowledge.sh" "$DSA1")
DSA2JSON=$$.dsa2.json
bash "${MYPATH}/../exist.sh" "$ENVNAME" "$DXA2" "$DSA2" > "$DSA2JSON"
STATUS=$?
if [ $STATUS -ne 0 ]; then
    cat "$DSA2JSON"
    exit "$STATUS"
fi
DSA2K=$(cat "$DSA2JSON" | bash "${MYPATH}/jknowledge.sh" "$DSA2")
#
# add DSA2 to DSA1
#
DSAP=$(cat "$DSA1JSON" | 
    ./jq --arg s "$DSA2" --arg x "$DXA2" \
        'select(.dsaPeers != null) | .dsaPeers 
         | map(select(.dsa == $s and .dxagent == $x))')
if [ -z "$DSAP" ] || [ $(echo "$DSAP" | ./jq 'length') -lt 1 ] ; then
    JSON=$$.json
    cat "$DSA1JSON" | \
        ./jq ".dsaPeers += [ { dxagent: \"$DXA2\", dsa: \"$DSA2\"}]" | \
        ./jq --argjson a2 "$DSA2K" '.config.knowledge += [ $a2 ] ' > "$JSON"
    bash "${MYPATH}/../update.sh" "$ENVNAME" "$DXA1" "$DSA1" "$JSON"
else
    cat "$DSA1JSON"
fi
#
# add DSA1 to DSA2
#
DSAP=$(cat "$DSA2JSON" | 
    ./jq --arg s "$DSA1" --arg x "$DXA1" \
        'select(.dsaPeers != null) | .dsaPeers 
         | map(select(.dsa == $s and .dxagent == $x))')
if [ -z "$DSAP" ] || [ $(echo "$DSAP" | ./jq 'length') -lt 1 ] ; then
    JSON=$$.json
    cat "$DSA2JSON" | \
        ./jq ".dsaPeers += [ { dxagent: \"$DXA1\", dsa: \"$DSA1\"}]" | \
        ./jq --argjson a1 "$DSA1K" '.config.knowledge += [ $a1 ] ' > "$JSON"
    bash "${MYPATH}/../update.sh" "$ENVNAME" "$DXA2" "$DSA2" "$JSON"
else
    cat "$DSA2JSON"
fi
