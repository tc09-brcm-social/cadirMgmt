#!/bin/bash
ENVNAME=$1
DXA1=$2
DSA1=$3
DXA2=$4
DSA2=$5
MYPATH=$(cd $(dirname "$0"); pwd)
#
# rm DSA2 from DSA1
#
DSA1JSON=$$.dsa1.json
bash "${MYPATH}/../exist.sh" "$ENVNAME" "$DXA1" "$DSA1" > "$DSA1JSON"
STATUS=$?
if [ $STATUS -ne 0 ]; then
    cat "$DSA1JSON"
else
    DSAK=$(cat "$DSA1JSON" | \
        ./jq --arg k "$DSA2" \
            'select(.config.knowledge != null) | .config.knowledge
             | map(select(.name != $k))')
    DSAP=$(cat "$DSA1JSON" | 
        ./jq --arg s "$DSA2" --arg x "$DXA2" \
            'select(.dsaPeers != null) | .dsaPeers 
             | map(select(.dsa != $s or .dxagent != $x))')
    JSON=$$.json
    if [ -z "$DSAK" ] || [ $(echo "$DSAK" | ./jq 'length') -lt 1 ] ; then
        cat "$DSA1JSON" | ./jq 'del(.config.knowledge)' > "$JSON"
    else
        cat "$DSA1JSON" | ./jq --argjson k "$DSAK" \
            '.config.knowledge = $k'  > "$JSON"
    fi
    if [ -z "$DSAP" ] || [ $(echo "$DSAP" | ./jq 'length') -lt 1 ] ; then
        cat "$JSON" | ./jq 'del(.dsaPeers)' > "$DSA1JSON"
    else
        cat "$JSON" | ./jq --argjson p "$DSAP" \
            '.dsaPeers = $p' > "$DSA1JSON"
    fi
    cat "$DSA1JSON" | bash "${MYPATH}"/../cleanse.sh > "$JSON"
    bash "${MYPATH}/../update.sh" "$ENVNAME" "$DXA1" "$DSA1" "$JSON"
fi
#
# rm DSA1 from DSA2
#
DSA2JSON=$$.dsa2.json
bash "${MYPATH}/../exist.sh" "$ENVNAME" "$DXA2" "$DSA2" > "$DSA2JSON"
STATUS=$?
if [ $STATUS -ne 0 ]; then
    cat "$DSA2JSON"
else
    DSAK=$(cat "$DSA2JSON" | \
        ./jq --arg k "$DSA1" \
            'select(.config.knowledge != null) | .config.knowledge
             | map(select(.name != $k))')
    DSAP=$(cat "$DSA2JSON" | 
        ./jq --arg s "$DSA1" --arg x "$DXA1" \
            'select(.dsaPeers != null) | .dsaPeers 
             | map(select(.dsa != $s or .dxagent != $x))')
    JSON=$$.json
    if [ -z "$DSAK" ] || [ $(echo "$DSAK" | ./jq 'length') -lt 1 ] ; then
        cat "$DSA2JSON" | ./jq 'del(.config.knowledge)' > "$JSON"
    else
        cat "$DSA2JSON" | ./jq --argjson k "$DSAK" \
            '.config.knowledge = $k'  > "$JSON"
    fi
    if [ -z "$DSAP" ] || [ $(echo "$DSAP" | ./jq 'length') -lt 1 ] ; then
        cat "$JSON" | ./jq 'del(.dsaPeers)' > "$DSA2JSON"
    else
        cat "$JSON" | ./jq --argjson p "$DSAP" \
            '.dsaPeers = $p' > "$DSA2JSON"
    fi
    cat "$DSA2JSON" | bash "${MYPATH}/../cleanse.sh" > "$JSON"
    bash "${MYPATH}/../update.sh" "$ENVNAME" "$DXA2" "$DSA2" "$JSON"
fi
