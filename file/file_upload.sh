#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
LDIF=$1
if [[ -z "$LDIF" ]] ; then
    >&2 echo "LDIF file required"
    exit 1
fi
. "$MYPATH/env.shlib"
VER=$(bash utils/curlver.sh)
if [[ "$VER" < "$TESTEDCURL" ]]; then
    >&2 echo "$0 requies curl version newer than $TESTEDCURL"
    exit 1
fi
ADDL="--header,Accept: application/json,-H,Content-Type: multipart/form-data,-F,uploadedFile=@${LDIF}"
bash "${MYPATH}/file_upload/coreZ00/post.sh" "" "$ADDL"
