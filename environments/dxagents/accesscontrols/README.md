* create.sh envName dxagentName JSONFile -- create an access control
	* using a JSONFile
	* readOnly is actually set at the file system level
* delete.sh envName dxagentName acName -- delete an access control
* dxccreate.sh envName dxagentName dxcName dxcFile -- create an access control
	* using a DXCFile. It invokes create.sh
* dxcupdate.sh envName dxagentName dxcName dxcFile -- update an access control
	* using a DXCFile. It invokes update.sh
* exist.sh envName dxagentName acName optionalAttrs -- exit code 1
	* when not exist, otherwise same as read.sh
* list.sh envName dxagentName -- use exist.sh to determine exit code,
* list.sh envName dxagentName acName -- use exist.sh to determine exit code,
        * output an array of an access control
* maketemp.sh envName dxagentName acName -- use exist.sh to dermine exit code
        * output a shell script that works as a template
        * only name is parameterised
* read.sh envName dxagentName '' optionalAttrs
* read.sh envName dxagentName acName optionalAttrs
        * the available attributes include data,name,readOnly
	* default attributes include name.readOnly
* update.sh envName dxagentName acName JSONFile -- update an access control
	* using a JSONFile
        * all intended attributes need to be included, not just
	* the to-be-updated ones data is required
	* readOnly is actually set at the file system level
        * name is ignored
