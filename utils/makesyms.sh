#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
cd "$MYPATH"/..
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
## symlinks
#
makesym() {
    local _srcfile=$1
    local _file=$2
    if [ ! -f "$_srcfile" ] && [ ! -d "$_srcfile" ] ; then
        >&2 echo "$_srcfile does not exit, skipped ..."
        return
    fi

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
