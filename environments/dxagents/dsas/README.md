# environments/dxagents/dsas
* cleanse.sh -- cleansing the JSON data from stdin for create.sh/update.sh
* create.sh envName dxagentName JSONFile -- create a DSA using a JSONFile
* delete.sh envName dxagentName DSAName OptionalInitOthers0or1 OptionalDelete_db_all0or1 OptionalDelete_db0or1
	* -- delete a DSA
	* The most common usage of the optionals is "" 1 ""
	* in order to delete all data files on the server.
* exist.sh envName dxagentName DSAName optionalAttrs -- exit code 1
	* when not exist, otherwise same as read.sh
* emptydb.sh envName dxagentName DSAName -- emptydb of a stopped DSA
* junsetpeers.sh -- expects a DSA JSON payload and removes
	* the DSA peers
* list.sh envName dxagentName -- use exist.sh to determine exit code
* list.sh envName dxagentName DSAName -- use exist.sh to determine
	* the exit code, output an array of DSAs
* maketemp.sh envName dxagentName DSAName -- use exist.sh to determine
	* the exit code, output a shell script that works as a template
	* only name is parameterised
	* default status is set to stopped
* read.sh envName dxagentName '' optionalAttrs
* read.sh envName dxagentName DSAName optionalAttrs
	* the available attributes could be found using read.sh then jq 'keys'
* status.sh envName dxaName optionalDSAName -- get the status of the DSAs
* update.sh envName dxagentName DSAName JSONFile -- update a DSA using
	* a JSONFile. All intended attributes need to be included,
	* not just the to-be-updated ones
	* name is ignored
