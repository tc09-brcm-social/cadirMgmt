#!/bin/bash
JSON="$(cat)"
RAW="$(echo "$JSON" | ./jq '.config.raw')"
LEN="$(echo "$RAW" | ./jq 'length')"
RAWS='[]'
for ((i = 0; i < $LEN; ++i)) ; do
    RAWS="$(echo "$RAWS" | \
            ./jq --arg s "$(echo "$RAW" | ./jq -r ".[$i]" | base64 --decode)" '. + [$s]')"
done
echo "$JSON" | ./jq --argjson a "$RAWS" '{ "name": .name, "raw": $a }'
