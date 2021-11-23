#!/bin/bash
MYPATH=$(cd $(dirname "0"); pwd)
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
DXAGENT=$NAME
if EXIST=$(bash dxagents/exist.sh "$ENVNAME" "$DXAGENT"); then
    >&2 echo "$DXAGENT exits, existing ..."
    echo "$EXIST" | bash dxagents/cleanse.sh
    exit
fi
>&2 echo "Preparing for self registration ..."
bashPath() {
   local _result
   if [[ $1 =~ ^.: ]]; then
      _result=$(echo "/$1" | tr -s ':\\\\' /)
   else
      _result=$1
   fi
   echo $_result
}
if [ -z "$DXHOME" ]; then
   #DXHOME="/c/Program Files/CA/Directory/dxserver/dxagent"
   DXHOME="/opt/CA/Directory/dxserver"
fi
DXAHOME=$(bashPath "$DXHOME")/dxagent
echo "$DXAHOME"
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
echo "$EXIST" | bash dxagents/cleanse.sh
