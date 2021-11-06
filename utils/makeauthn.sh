#!/bin/bash
. utils/env.shlib
ADMINCRED=$(echo -n "$ADMINID:$ADMINPASS" | base64)
USERCRED=$(echo -n "$USERID:$USERPASS" | base64)
bash authn.sample.temp "${ADMINCRED}" "${USERCRED}" "$RESTHOST" "$RESTPORT" "$SCIMPORT"> authn
