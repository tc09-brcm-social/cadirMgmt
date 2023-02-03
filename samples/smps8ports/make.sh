#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
cd "${MYPATH}"
. ./env.shlib
resetbase
LINES="$(grep '^[^# ]*=' env.shlib | sed 's/=.*$//')"
for i in $LINES ; do
    envbase "$i" "$(eval 'echo $'$i)"
done

