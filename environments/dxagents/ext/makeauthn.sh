#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
CHILD=$2
FNAME=$3
AUTHNTEMP=$4
DEST=$5
if [ -z "$FNAME" ] ; then
    >&2 echo "Usage: $0 envName dxaName filename authnTemp optionDir"
    >&2 echo "filename is required"
    exit 1
fi
if [ -z "$AUTHNTEMP" ] ; then
    >&2 echo "Usage: $0 envName dxaName filename authnTemp optionDir"
    >&2 echo "authnTemp is required"
    exit 1
fi
if [ -z "$DEST" ] ; then
    DEST=.
fi
EXIST=$(bash "${MYPATH}/../exist.sh" "$NAME" "$CHILD" host,port,clientCertPem,clientKeyPem)
STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo "$EXIST"
    exit "$STATUS"
fi
HOST=$(echo "$EXIST" | ./jq -r '.host')
PORT=$(echo "$EXIST" | ./jq -r '.port')
echo "$EXIST" | ./jq -r '.clientCertPem' >  "${DEST}/${FNAME}.pem"
echo "$EXIST" | ./jq -r '.clientKeyPem' >  "${DEST}/${FNAME}.key"
bash "$AUTHNTEMP" "$HOST" "$PORT" "$FNAME"
#cat <<EOF
##!/bin/bash
#DXAGENTC=${FNAME}
#AUTHN="--key ./${FNAME}.key --cert ./${FNAME}.pem"
#RESTHOST=$HOST
#RESTPORT=$PORT
#EOF

