# samples/smps2
This sample twice uses samples/smps1 to create
three data DSAs, policy store, session store, and sample user store used
by a SiteMinder policy server.
After both sets are created, it then establishs the
peer knowledge between two sets and set session store write-precence.
It does not try to start these DSAs.
You can use other scripts to start/stop these DSAs.
* env.shlib
	* used to customize the running of this sample.
	* You want to set your own password.
	* You can set your own environment name.
	* The dxagent names need to be pre-registered
	* with the registrar environment to work.
* make.sh - to create
	* make.sh is actually linking makeenvdxagent, makeschemas,
	* and makedsas to make the whole set of scripts
	* less clustered.
* unmake.sh - to remove
* startall.sh -- to start all DSAs in this set
* stopall.sh -- to stop all DSAs in this set
* status.sh -- to check status of all DSAs in this set
