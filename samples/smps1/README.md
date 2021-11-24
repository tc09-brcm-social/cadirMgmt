# samples/smps1
This sample creates one router DSA and
three data DSAs, policy store, session store, and sample user store used
by a SiteMinder policy server.
* env.shlib
	* used to customize port numbers and DSA names
* make.sh - to create
	* make.sh is actually linking makeenvdxagent, makeschemas,
	* and makedsas to make the whole set of scripts
	* less clustered.
* unmake.sh - to remove
* startall.sh -- to start all DSAs in this set
* stopall.sh -- to stop all DSAs in this set
