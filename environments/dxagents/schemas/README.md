* create.sh envName dxagentName JSONFile -- create a schema using a JSONFile
	* readOnly is actually set at the file system level
* delete.sh envName dxagentName schemName -- delete a schema
* dxccreate.sh envName dxagentName dxcName DXCFile -- create the schema
	* using the given name and a DXCFile, it invokes create.sh 
* dxcupdate.sh envName dxagentName dxcName DXCFile -- update the schema
	* using a DXCFile, it invokes update.sh 
* exist.sh envName dxagentName schemaName optionalAttrs -- exit code 1
	* when not exist, otherwise same as read.sh
* list.sh envName dxagentName -- use exist.sh to determine exit code,
* list.sh envName dxagentName schemaName -- use exist.sh to determine
	* the exit code,output an array of schemas
* maketemp.sh envName dxagentName schemaName -- use exist.sh to dertermine
	* the exit code, output a shell script that works as a template
        * only name is parameterised
* read.sh envName dxagentName '' optionalAttrs
* read.sh envName dxagentName schemaName optionalAttrs
        * the available attributes include data,name,readOnly
	* default attributes include name.readOnly
* showdata.sh envName dxagentName schemaName -- show the DXC data
	* of a schema
* update.sh envName dxagentName schemaName JSONFile -- update a schema
	* using a JSONFile all intended attributes need to be included,
	* not just the to-be-updated ones
	* data is required
	* readOnly is actually set at the file system level
        * name is ignored
