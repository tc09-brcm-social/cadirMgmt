#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
cd ../..
HOMEDIR=$(pwd)
. "$MYPATH"/env.shlib
cd "$MYPATH/${JSONDIR}"
JSON=$(bash make.sh)
cd "$HOMEDIR"
if [ -z "$DBSIZE" ] ; then
  DBSIZE=$(echo "$JSON" | ./jq -r '.config.server."dxgrid-db-size"')
fi
if [ ! -z "$PREFIX" ] ; then
    APREFIX=,$PREFIX
fi
echo "$JSON" | bash dsas/cleanse.sh | \
    ./jq -S ".config.knowledge[0].prefix = \"${PREFIX}\""'
      | .config.knowledge[0]."trust-flags" += [ "allow-check-password" ]
      | .config.server."dxgrid-db-size" = '"$DBSIZE"'
      ' | \
    bash dsas/jsetsettings.sh "mimic-netscape-for-siteminder" true | \
    bash dsas/jsetsettings.sh "hold-ldap-connections" true | \
    bash dsas/jsetsettings.sh "concurrent-bind-user" \
        "[\"uid=smadmin,ou=admins${APREFIX}\"]" \
