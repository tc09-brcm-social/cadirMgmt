* create.sh JSONFileName -- create an environment using a JSON file
* delete.sh envName -- delete an environment
* exist.sh -- exit code 1 when not exist, otherwise same as read.sh
* exist.sh envName -- exit code 1 when not exist, otherwise same as read.sh
* list.sh optionalEnvName -- use exist.sh to determine exit code,
	* output an array of environments
* maketemp.sh envName -- make a template from an existing environment
* read.sh -- GET all environments in a JSON array
* read.sh envName -- GET an environment
* update.sh envName JSONFileName -- update an environment using a JSON file
	* The JSONFile needs to contain all the desired attributes
	* not just those to be updated.
	* the naming attribute is ignored, however.

