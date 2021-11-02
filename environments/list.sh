#!/bin/bash
MYPATH=$(cd $(dirname $0); pwd)
bash "${MYPATH}/read.sh" | ./jq '[.[]| .name]'
