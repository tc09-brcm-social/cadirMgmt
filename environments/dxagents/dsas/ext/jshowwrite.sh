#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
cat | ./jq '.config.settings."write-precedence"'
