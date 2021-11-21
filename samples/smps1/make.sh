#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
bash makeenvdxagent.sh
cd "$MYPATH"
bash makeschemas.sh
cd "$MYPATH"
bash makedsas.sh
