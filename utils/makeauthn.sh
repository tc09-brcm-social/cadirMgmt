#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
. "$MYPATH/env.shlib"
ADMINCRED=$(echo -n "$ADMINID:$ADMINPASS" | base64)
USERCRED=$(echo -n "$USERID:$USERPASS" | base64)
bash "$MYPATH/authn.sample.temp" "${ADMINCRED}" "${USERCRED}" \
    "$MANAGERHOST" "$MANAGERPORT" "$SCIMPORT"> "$MYPATH/../authn"
