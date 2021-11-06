# environments/dxagents/dsas/objectclasses
* exist.sh envName dxagentName DSAName optionalOC -- exit code 1
	* when not exist, otherwise same as read.sh
* list.sh envName dxagentName DSAName optionalOC -- use exist.sh to determine
	* the exit code, output an array of LDAP objectclasses
* read.sh envName dxagentName DSAName optionalOC
	* output the LDAP objectclasses a DSA knows
