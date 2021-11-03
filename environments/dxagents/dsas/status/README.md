# environments/dxagents/dsas/status
* init.sh envName dxagentName dsaName -- init a DSA using the update.sh
	* this reload the applicable config changes
* forcestart.sh envName dxagentName dsaName -- force start a DSA
* forcestop.sh envName dxagentName dsaName -- force stop a DSA
	* forcestop a DSA would stop a DSA that is waiting for
	* finishing multi-write queue to stop immediately
* start.sh envName dxagentName dsaName -- start a DSA
* stop.sh envName dxagentName dsaName -- stop a DSA
* update.sh envName dxagentName dsaName JSONFile -- update dsa status
	* using a JSON file
	* This is used primarily by the other actions
