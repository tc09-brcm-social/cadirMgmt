# environments/dxagents/dsas/ext
* addpeers.sh ENVNAME DXA1 DSA1 DXA2 DSA2 -- add bidirectional
	* peers between DXA1/DSA1 and DXA2/DSA2
	* in the same environment
* addwrite.sh ENVNAME DXA1 DSA1 DXA2 DSA2 -- add DSA2
	* to the DSA1 write-precedence list
* jaddwrite.sh DSA -- add DSA to the write-prcedence list
	* of the JSON DSA object
* jknowledge.sh DSA -- output the DSA knowledge in the DSA JSON
	* object, return as an object, not array 
* jrmwrite.sh DSA -- remove DSA from the write-precedence list
	* of the JSON DSA object
* jshowpeers.sh -- show DSA peers in the DSA JSON object
	* attriutes including name, status, and dsaPeers
* jshowwrite.sh -- show the write-procedence list
* rmpeers.sh ENVNAME DXA1 DSA1 DXA2 DSA2 -- attempt to remove
	* bidirectional peers. It continues to operate
	* even when a DSA no longer exists.
