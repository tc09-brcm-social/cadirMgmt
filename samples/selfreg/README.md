# samples/selfreg
Other than the connectity to the Directory Manger UI,
this is the beginning of using this Directory Manager RestAPI framework.
This sample connects to the already configured Directory Manager
to register an additional dxagent to the registrar environment.
It also creates two default DSAs, one DATA, one Router, designed
to be used to create other DSAs on the same dxagent.
* Getting Started
	* Following the main README.md to meet the pre-requsites and
	* establish the connectivity to the designated Directory Manager.
	* Modify the env.shlib to provide NAME, a unique short name for
	* this dxagent; DXAHOST, DXAPORT, the  machine name and port 
	* the Directory Manager can resolve and connect to the dxagent;
	* DXACLIENT, if you know the client name during the installation
	* of the dxagent, if not make.sh script will attempt to determine
	* the client name.
	*
	* run "bash make.sh" afterwards.
* make.sh - to connect to the default Directory Manager
	* to create the registrar environment if not yet exists and
	* to register this additional dxagent in it.
	* It also creates a default DATA and a default ROUTER DSAs.
	*
	* You may want to export the DXHOME environment variable
	* before running the "bash make.sh".
	* The DXHOME environment variable is usually set to
	* the home directory of where the Directory is installed.
* unmake.sh - to remove the default DATA and ROUTER DSAs,
	* to remove the dxagent from the registrar environment
	* When the number of the dxagents becomes 0,
	* the registrar envionment is also removed.
* defenv.shlib -- contains values used to create the DSAs.
