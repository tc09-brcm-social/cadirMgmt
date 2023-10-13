#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
cd "$MYPATH"
. ./env.shlib
mount -r -t iso9660 -o loop -v "$ISO" "$MOUNT"
cd "$MOUNT/linux_x86_64/management-ui/install"
./dxmgmtuisetup.sh -responsefile "$RSP"
