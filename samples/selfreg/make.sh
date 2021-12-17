#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
bash "${MYPATH}"/makeenvlib.sh; STATUS=$?
if [ "$STATUS" -ne 0 ]; then
    exit 1
fi
. "${MYPATH}"/../env.shlib
. "${MYPATH}"/env.shlib
cd ../..
#
# Environment
#
ENVNAME=$REGISTRARENV${TEST}
if ! EXIST=$(bash environments/exist.sh "$ENVNAME"); then
    JSON=$$.json
    bash environments/temp/simple.temp "$ENVNAME" | \
        ./jq '. + { description: "Registrar Environment - do not edit"}' >$JSON
    EXIST=$(bash environments/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.'
bashPath() {
   local _result
   if [[ $1 =~ ^.: ]]; then
      _result=$(echo "/$1" | tr -s ':\\\\' /)
   else
      _result=$1
   fi
   echo $_result
}
DXAGENT=$NAME
if ! EXIST=$(bash dxagents/exist.sh "$ENVNAME" "$DXAGENT"); then
    >&2 echo "Preparing for self registration ..."
    if [ -z "$DXHOME" ]; then
       #DXHOME="/c/Program Files/CA/Directory/dxserver/dxagent"
       DXHOME="/opt/CA/Directory/dxserver"
    fi
    DXAHOME=$(bashPath "$DXHOME")/dxagent
    if ! EXIST=$(bash dxagents/exist.sh "$ENVNAME" "$DXAGENT"); then
       HOST="$DXAHOST"
       CAPEM="$DXAHOME/openssl-ca/CA/certs/ca.pem"
       CLIENTPEM="$DXAHOME/openssl-ca/out/${DXACLIENT}.pem"
       CLIENTKEY="$DXAHOME/openssl-ca/out/${DXACLIENT}.key"
       JSON=$$.json
       bash dxagents/temp/simple1.temp "${DXAGENT}" "${HOST}" "${DXAPORT}" \
            "${CLIENTPEM}" "${CLIENTKEY}" "${CAPEM}" > $JSON
       EXIST=$(bash dxagents/create.sh "$ENVNAME" "$JSON")
    fi
fi
echo "$EXIST" | bash dxagents/cleanse.sh
DXAHOST=$(echo "$EXIST" | ./jq -r '.host')
VER=$(bash dxagents/about.sh "$ENVNAME" "$DXAGENT" | \
      ./jq -r '.version' | awk '{print $2}')
#
# Default Data DSA
#
DSA=default.${VER}${TEST}
. "$MYPATH/defenv.shlib"
if [ -z "$LDAPHOST" ] ; then
    LDAPHOST="$DXAHOST"
fi
if ! EXIST=$(bash dsas/exist.sh "$ENVNAME" "$DXAGENT" "$DSA"); then
    >&2 echo "making $ENVNAME" "$DXAGENT" "$DSA"
    JSON=$$.json
    bash "dsas/temp/default.temp" "$DSA" "$LDAPHOST" "$PORTD" > "$JSON"
    EXIST=$(bash dsas/create.sh "$ENVNAME" "$DXAGENT" "$JSON")
    bash dsas/emptydb.sh "$ENVNAME" "$DXAGENT" "$DSA"
fi
echo "$EXIST" | bash dsas/cleanse.sh
#
# Default Router DSA
#
DSA=defrouter.${VER}${TEST}
if ! EXIST=$(bash dsas/exist.sh "$ENVNAME" "$DXAGENT" "$DSA"); then
    >&2 echo "making $ENVNAME" "$DXAGENT" "$DSA"
    JSON=$$.json
    bash "dsas/temp/defrouter.temp" "$DSA" "$LDAPHOST" "$PORTR" > "$JSON"
    EXIST=$(bash dsas/create.sh "$ENVNAME" "$DXAGENT" "$JSON")
fi
echo "$EXIST" | bash dsas/cleanse.sh
