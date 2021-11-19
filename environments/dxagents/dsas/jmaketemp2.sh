#!/bin/bash
MYPATH=$(dirname "$0")
EXIST=$(cat | bash "${MYPATH}/cleanse.sh" | bash "${MYPATH}/junsetpeers.sh")
PREFIX=$(echo "$EXIST" | ./jq -r '.config.knowledge[0].prefix')
if [ -z "$PREFIX" ] ; then
    CNAME='cn=${NAME}'
else
    CNAME='cn=${NAME},${PREFIX}'
fi
echo '#!/bin/bash'
echo 'NAME=$1'
echo 'LDAPHOST=$2'
echo 'LDAPPORT=$3'
echo 'LDAPPORTA=$(expr $LDAPPORT + 1)'
echo "PREFIX=\"${PREFIX}\""
echo "CNAME=\"${CNAME}\""
echo 'RANDOM=$$'
echo 'cat <<EOF'
echo "$EXIST" | \
    ./jq -S '. + { "name": "${NAME}", "status": "stopped" } | 
          .config.knowledge[0].name = "${NAME}" | 
          .config.knowledge[0].prefix = "${PREFIX}" | 
          .config.knowledge[0]."dsa-name" = "${CNAME}" | 
          .config.knowledge[0]."dsa-password" = "${NAME}${RANDOM}" | 
          .config.knowledge[0]."console-port" = "$LDAPPORTA" | 
          .config.knowledge[0]."snmp-port" = "$LDAPPORT" | 
          .config.knowledge[0].interface[0].address = "${LDAPHOST}" | 
          .config.knowledge[0].interface[0].port = "$LDAPPORT"' | \
    sed 's/\(\$[^{]\)/\\\1/g' | sed 's/"\\\$\([A-Z]*\)"/$\1/g'
echo 'EOF'
