#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
DXANAME=$1
if [ -z "$DXANAME" ] ; then
    >&2 echo "Usage: $0 DXANAME -- DXANAME required"
    exit 1
fi
cd ../..
HOMEDIR=$(pwd)
. "$MYPATH"/env.shlib
cd "$MYPATH/${JSONDIR}"
JSON=$(bash make.sh "$DXANAME")
cd "$HOMEDIR"
###
# https://techdocs.broadcom.com/us/en/symantec-security-software/identity-security/siteminder/12-8/installing/install-a-policy-server/configure-ldap-directory-servers-as-policy-session-and-key-stores/configure-an-ldap-directory-server-as-a-policy-store/configure-a-ca-directory-policy-store.html
#
# 1. copy the netegrity.dxc and etrust.dxc
# 2.
# 3. add netegrity.dxc, etrust.dxc after the default.
# 4.
# 5. set ignore-name-bindings = true;
# 6.
# 7. Limits
#    set max-users = 1000;
#    set credits = 5;
#    set max-local-ops = 1000;
#    set max-op-size = 4000;
#    set multi-write-queue = 20000;
# 8.
# 9.
# 10.
#
###
if [ -z "$DBSIZE" ] ; then
  DBSIZE=$(echo "$JSON" | ./jq -r '.config.server."dxgrid-db-size"')
fi
echo "$JSON" | bash dsas/cleanse.sh | \
    ./jq -S --argjson c "$CACHEINDEX" --argjson d "$DSAFLAGS" \
      '.config.knowledge[0].prefix = "'${PREFIX}'"
      | .config.knowledge[0]."trust-flags" += [ "allow-check-password" ]
      | .config.server."dxgrid-db-size" = '"$DBSIZE"'
      | .config.schema += ["netegrity.dxc", "etrust.dxc"] 
      | .config.settings."ignore-name-bindings" = true
      | .config.limits."max-users" = 1000
      | .config.limits."credits" = 5
      | .config.knowledge[0]."credits" = 5
      | .config.limits."max-local-ops" = 1000
      | .config.limits."max-op-size" = 4000
      | .config.limits."multi-write-queue" = 20000
      | .config.server = { "cache-index" : $c } + .config.server
      | .config.knowledge[0]."dsa-flags" = $d
      '
