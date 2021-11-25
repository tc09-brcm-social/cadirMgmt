# samples/smps1
This sample creates one router DSA and
three data DSAs, policy store, session store, and sample user store used
by a SiteMinder policy server.
* env.shlib
        * used to customize the running of this sample.
        * You can set your own environment name.
        * The dxagent names need to be pre-registered
        * with the registrar environment.
* make.sh - to create
	* make.sh is actually linking makeenvdxagent, makeschemas,
	* and makedsas to make the whole set of scripts
	* less clustered.
* unmake.sh - to remove
* startall.sh -- to start all DSAs in this set
* stopall.sh -- to stop all DSAs in this set
* status.sh -- to check status of all DSAs in this set
* etrust.dxc, netegrity.dxc -- are copied from SiteMinder 12.8.
