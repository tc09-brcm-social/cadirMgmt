#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
NAME=$1
CHILD=$2
GCHILD=$3
initOthers=$4
delete_db_all=$5
delete_db=$6
QUERY=
LEAD=
if [ ! -z "$initOthers" ] ; then
    QUERY="${LEAD}initOthers=$initOthers$QUERY"
    LEAD=&
fi
if [ ! -z "$delete_db_all" ] ; then
    QUERY="${LEAD}delete_db_all=$delete_db_all$QUERY"
    LEAD=&
fi
if [ ! -z "$delete_db" ] ; then
    QUERY="${LEAD}delete_db=$delete_db$QUERY"
    LEAD=&
fi
EXIST=$(bash ${MYPATH}/exist.sh "$NAME" "$CHILD" "$GCHILD"); STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo "$EXIST"
    exit "$STATUS"
fi
bash "${MYPATH}/coreZ010101/delete.sh" "${NAME}" "${CHILD}" "${GCHILD}" "$QUERY"
