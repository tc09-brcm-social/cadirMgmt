#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
cat | bash "${MYPATH}/../cleanse.sh" | ./jq --arg n "$NAME" \
    '.config.knowledge[] | select(.name == $n)'
