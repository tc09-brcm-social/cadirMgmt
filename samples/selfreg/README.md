# samples/registrar
In addition to the samples/base that creates the base environment,
registrar environment is used to gather all managed dxagents.
This registrar allow easier configurations across multiple dxagents.
* Getting Started
	* Modify the env.shlib to provide the connectivity
	* information for the DXAGENT to be registered.
	* This DXAGENT machine is assumed to have
	* the dxserver, dxagent, and Diretory Manager installed.
	* In addition, the samples/base should have been run on that machine.
	* ADMINID - the admin ID to the Directory Manager UI being registered
	* ADMINPASS - the password to the Directory Manager UI being registered
	* HOST - IP/Host Name of the dxagent being registered
	* PORT - Port number of the Directory Manager
	* NAME - tends to be a short name for the dxagent
	*
	* run "bash make.sh" afterwards.
* make.sh - to connect to the default Directory Manager
	* to register an additional dxagent in the
	* registrar environment.
	* During the process, it connects to the 
	* Directory Manager UI on the dxagent being registered
	* to retrieve the default dxagent of the default environment
	* then register it.
* unmake.sh - to remove the dxagent from the
	* registrar environment of the default Directory Manager
	* When the number of the dxagents becomes 0,
	* the registrar envionment is also removed.
