# environments/dxagents/dsas/ext
* addpeers.sh ENVNAME DXA1 DSA1 DXA2 DSA2 -- add bidirectional
	* peers between DXA1/DSA1 and DXA2/DSA2
	* in the same environment
* jknowledge.sh DSA -- output the DSA knowledge in the DSA JSON
	* object, return as an object, not array 
* jshowpeers.sh -- show DSA peers in the DSA JSON object
	* attriutes including name, status, and dsaPeers
* rmpeers.sh ENVNAME DXA1 DSA1 DXA2 DSA2 -- attempt to remove
	* bidirectional peers. It continues to operate
	* even when a DSA no longer exists.
