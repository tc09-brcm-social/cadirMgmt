# environments/dxagents
* about.sh envName dxagentName -- output a JSON object that
	* contains the version of the dxagent
* cleanse.sh -- cleansing the JSON data from stdin for create.sh/update.sh
* create.sh envName JSONFile -- create a dxagent in an environment
	* using a JSON File
* delete.sh envName dxagentName -- delete a dxagent from an environment
* exist.sh envName '' optionalAttrs -- exit code 1 when not exist,
	* otherwise same as read.sh
* exist.sh envName dxagentName optionalAttrs -- exit code 1 when not exist,
	* otherwise same as read.sh
* list.sh envName -- use exist.sh to determine exit code,
* list.sh envName dxagentName -- use exist.sh to determine exit code,
	* output an array of dxagents
* jmaketemp.sh -- create template script from a dxagent JSON object
* maketemp.sh envName dxagentName -- create template script from
	* on an existing dxagent
	* the certificates are captured in the template
* read.sh envName '' optionalAttrs -- GET all dxagents in an array
* read.sh envName dxagentName optionalAttrs -- GET a dxagent
	* optionAttrs is comma separated attributes to read
	* the available attributes could be obtained first doing it without
	* any of the attributes and send the output to jq 'keys'
* update.sh envName dxagentName JSONFile -- update a dxagent in
	* an environment using a JSON File
	* all attributes to use are required, name is ignored however
