#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
LDIF=$1
if [[ -z "$LDIF" ]] ; then
    >&2 echo "LDIF file required"
    exit 1
fi
ADDL="--header,Accept: application/json,-H,Content-Type: multipart/form-data,-F,uploadedFile=@${LDIF}"
bash "${MYPATH}/file_upload/coreZ00/post.sh" "" "$ADDL"
