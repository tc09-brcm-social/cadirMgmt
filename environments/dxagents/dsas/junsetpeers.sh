#!/bin/bash
JSON=$$.json
NAME=$(cat | tee "$JSON" | ./jq -r '.name')
./jq --arg n "$NAME" \
    'del(.dsaPeers) | del(.config.knowledge[] | select(.name != $n))' "$JSON"
