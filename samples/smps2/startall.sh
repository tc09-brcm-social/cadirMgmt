#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
cd ../..
HOMEDIR=$(pwd)
. "$MYPATH"/env.shlib
ENVSHLIB="$MYPATH"/"$SMPS1DIR"/env.shlib
#
## SMPS set 1
#
git checkout "$ENVSHLIB"
x=$(bash utils/setkeyvalue.sh "$ENVSHLIB" ENVNAME "$ENVNAME")
x=$(bash utils/setkeyvalue.sh "$ENVSHLIB" DXANAME "$DXA1")
x=$(bash utils/setkeyvalue.sh "$ENVSHLIB" PORT "$PORTS1")

x=$(bash utils/setkeyvalue.sh "$ENVSHLIB" ROUTERNAME "$ROUTER1DSA")

x=$(bash utils/setkeyvalue.sh "$ENVSHLIB" DATANAME "$UD1DSA")
x=$(bash utils/setkeyifvalue.sh "$ENVSHLIB" DATAPREFIX "$UDPREFIX")
x=$(bash utils/setkeyifvalue.sh "$ENVSHLIB" DATAPASS "$UDPASS")
x=$(bash utils/setkeyifvalue.sh "$ENVSHLIB" DATADBSIZE "$UDDBSIZE")

x=$(bash utils/setkeyvalue.sh "$ENVSHLIB" SMPSNAME "$PS1DSA")
x=$(bash utils/setkeyifvalue.sh "$ENVSHLIB" SMPSPREFIX "$PSPREFIX")
x=$(bash utils/setkeyifvalue.sh "$ENVSHLIB" SMPSPASS "$PSPASS")
x=$(bash utils/setkeyifvalue.sh "$ENVSHLIB" SMPSDBSIZE "$PSDBSIZE")

x=$(bash utils/setkeyvalue.sh "$ENVSHLIB" SMSSNAME "$SS1DSA")
x=$(bash utils/setkeyifvalue.sh "$ENVSHLIB" SMSSPREFIX "$SSPREFIX")
x=$(bash utils/setkeyifvalue.sh "$ENVSHLIB" SMSSPASS "$SSPASS")
x=$(bash utils/setkeyifvalue.sh "$ENVSHLIB" SMSSDBSIZE "$SSDBSIZE")

cd "$MYPATH"/"$SMPS1DIR"
bash startall.sh
cd "$HOMEDIR"
#
## SMPS set 2
#
git checkout "$ENVSHLIB"
x=$(bash utils/setkeyvalue.sh "$ENVSHLIB" ENVNAME "$ENVNAME")
x=$(bash utils/setkeyvalue.sh "$ENVSHLIB" DXANAME "$DXA2")
x=$(bash utils/setkeyvalue.sh "$ENVSHLIB" PORT "$PORTS2")

x=$(bash utils/setkeyvalue.sh "$ENVSHLIB" ROUTERNAME "$ROUTER2DSA")

x=$(bash utils/setkeyvalue.sh "$ENVSHLIB" DATANAME "$UD2DSA")
x=$(bash utils/setkeyifvalue.sh "$ENVSHLIB" DATAPREFIX "$UDPREFIX")
x=$(bash utils/setkeyifvalue.sh "$ENVSHLIB" DATAPASS "$UDPASS")
x=$(bash utils/setkeyifvalue.sh "$ENVSHLIB" DATADBSIZE "$UDDBSIZE")

x=$(bash utils/setkeyvalue.sh "$ENVSHLIB" SMPSNAME "$PS2DSA")
x=$(bash utils/setkeyifvalue.sh "$ENVSHLIB" SMPSPREFIX "$PSPREFIX")
x=$(bash utils/setkeyifvalue.sh "$ENVSHLIB" SMPSPASS "$PSPASS")
x=$(bash utils/setkeyifvalue.sh "$ENVSHLIB" SMPSDBSIZE "$PSDBSIZE")

x=$(bash utils/setkeyvalue.sh "$ENVSHLIB" SMSSNAME "$SS2DSA")
x=$(bash utils/setkeyifvalue.sh "$ENVSHLIB" SMSSPREFIX "$SSPREFIX")
x=$(bash utils/setkeyifvalue.sh "$ENVSHLIB" SMSSPASS "$SSPASS")
x=$(bash utils/setkeyifvalue.sh "$ENVSHLIB" SMSSDBSIZE "$SSDBSIZE")

cd "$MYPATH"/"$SMPS1DIR"
bash startall.sh
cd "$HOMEDIR"
