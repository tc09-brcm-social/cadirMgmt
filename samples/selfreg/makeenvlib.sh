#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
. "$MYPATH"/../env.shlib
. "$MYPATH"/env.shlib
cd ../..
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
   #DXAHOME="/c/Program Files/CA/Directory/dxserver/dxagent"
   DXHOME="/opt/CA/Directory/dxserver"
fi
DXAHOME=$(bashPath "$DXHOME")/dxagent
COUNT=0
for i in $(ls "$DXAHOME/openssl-ca/out/" | grep '\.p12$'); do
    >&2 echo $i
    DXACLIENT=$(basename $i | cut -f1 -d.)
    COUNT=$(expr $COUNT + 1)
done
if [ $COUNT == 1 ]; then
    >&2 echo Ready to modify "$MYPATH"/env.shlib
#    echo "DXACLIENT=$DXACLIENT" >> env.shlib
    x=$(bash utils/setkeyvalue.sh "$MYPATH"/env.shlib DXACLIENT "$DXACLIENT")
else
    >&2 echo This script change the env.shlib for installation specific
    >&2 echo when there is a single p12 file under the
    >&2 echo $DXAHOME/openssl-ca/out/. The current listing is:
    >&2 ls -l "$DXAHOME/openssl-ca/out/"
    >&2 echo This environment does not seem to satisfy this requirement.
    >&2 echo Please modify the env.shlib manually to set
    >&2 echo the DXACLIENT to the base the file name required
    >&2 echo and/or the DXHOME to the correct path that leads
    >&2 echo to the p12 file.
    exit 1
fi
