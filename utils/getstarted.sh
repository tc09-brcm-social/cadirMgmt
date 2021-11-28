#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
cd "$MYPATH"/..
. "$MYPATH/env.shlib"
#
## jq
#
if [ ! -f jq ] ; then
   JQPATH=$(which jq)
   if [ -z "$JQPATH" ] ; then
      >&2 echo "downloading jq"
      curl -o jq -L https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
      chmod +x jq
   else
      ln -s "$JQPATH"
   fi
fi
#
## symlinks
#
makesym() {
    local _srcfile=$1
    local _file=$2
    if [ -f "$_file" ] || [ -d "$_file" ] ; then
        >&2 echo "$_file exits, skipped ..."
    else
        >&2 echo "Making symlink to $_file"
        ln -s "$_srcfile" "$_file"
    fi
    }
makesym environments/dxagents/dsas dsas
makesym environments/dxagents dxagents
makesym environments/dxagents/schemas schemas
makesym environments/dxagents/accesscontrols accesscontrols
#
## cadirCurl and jq
#
if [ -f cadirCurl ] || [ -d cadirCurl ] ; then
    cd cadirCurl
    makesym ../jq jq
    cd ..
fi
#
## authn
#
if [ -z "$ADMINPASS" ] ; then
    >&2 echo "!!! Warning ... Modify the $MYPATH/env.shlib"
    >&2 echo to set the password and other parameters
    >&2 echo to connect to the Directory Manager.
    exit 1
fi
if [ -f authn ] ; then
    >&2 echo "Authentication module authn exits, not overwriting ..."
else
    >&2 echo "Making authentication module authn ..."
    bash "$MYPATH/makeauthn.sh" 
fi
