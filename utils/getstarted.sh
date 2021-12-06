#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
cd "$MYPATH"/..
. "$MYPATH/env.shlib"
#
## isWindow
#
isWindow() {
    UNAME=$(uname)
    if [[ "$UNAME" == "MINGW"* ]] ; then
	echo 0
    else
	echo 1
    fi	
    }
#
## jq
#
if [ ! -f jq ] ; then
   JQPATH=$(which jq)
   if [ -z "$JQPATH" ] ; then
      >&2 echo "downloading jq"
      if [ $(isWindow) -eq 0 ] ; then
         curl -o jq.exe -L \
            https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe
      else
         curl -o jq -L \
	    https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
         chmod +x jq
      fi
   else
      ln -s "$JQPATH"
   fi
fi
#
## symlinks
#
bash "$MYPATH/makesyms.sh"
#
## intdxagent
#
bash "$MYPATH/intdxagent.sh"
cd "$MYPATH"/..
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
