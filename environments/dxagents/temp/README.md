# environments/dxagents/temp
* simple.temp NAME HOST CLIENTPEM CLIENTKEY CAPEM -- template to create a dxagent
	* name needs to be unique within the environment
	* host needs to match the CN for the certificate the dxagent uses
	* CLIENTPEM, CLIENTKEY, CAPEM are the identity used
	* to connect to the dxagent
	* port number is assumed to be 9443
* simple1.temp NAME HOST PORT CLIENTPEM CLIENTKEY CAPEM
	* same as simple.temp except accepting a port number
