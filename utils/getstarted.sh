#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
cd "$MYPATH"/..
. "$MYPATH/env.shlib"
if [ -z "$ADMINPASS" ] ; then
    >&2 echo "Modify the $MYPATH/env.shlib"
    >&2 echo to set the password and other parameters
    >&2 echo to connect to the Directory Manager.
    exit 1
fi
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
ln -s environments/dxagents/dsas
ln -s environments/dxagents
ln -s environments/dxagents/schemas
ln -s environments/dxagents/accesscontrols
#
## authn
#
if [ -f authn ] ; then
    >&2 echo "Authentication module authn exits, not overwriting ..."
else
    >&2 echo "Making authentication module authn ..."
    bash "$MYPATH/makeauthn.sh" 
fi
