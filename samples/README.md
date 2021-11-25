# samples
* env.shlib -- contains the sample-wise environment variables
	* as appropriate. See env.shilb for more deteails.
* base -- a sample that is used to create a base environment and dxagent
	* It is recommended to run this example on a new
	* Directory server right after the dxserver, dxagent, and
	* Directory Manager are installed.
* datadsa -- creates a DATA DSA base on defdata
* defdata -- to obtain the JSON object of the default DATA DSA
	* through the dxagent in the registrar environment
* defrouter -- to obtain the JSON object of the default Router DSA
	* through the dxagent in the registrar environment
* envdxagent -- create a dxagent in a given environmet
	* using the info registered in the registrar envionment
* registrar -- to register an dxagent on the registrar environment
	* When there are multiple dxagent machines,
	* registering them on this same environment will make dxagent
	* connectivity information available for other environments.
* registrarDXA -- output the JSON payload of a dxagent in
	* the registrar environment 
* routerdsa -- creates a Router DSA base on defrouter
* routeduser -- creates a routed SiteMinder user DATA DSA/Router DSA
	* sample DATA is loaded and both DSAs are started
* selfreg -- self register to the registrar on the Directory Manager
	* need to setup the authn to point to the Directory Manager first
	* This is to run on the machine machine to be registered
	* as the script would collect the local client pem and key
* smuserjson -- outputs a sample SiteMinder User Directory DSA JSON payload
	* by default, it uses defdata to start building the payload
* smps1 -- creates an environment with a dxagent, then four
	* DSAs, router, policy store, session store, and user store.
	* initialize the three data stores and not explicitly
	* start them.
* smpsjson -- outputs a sample SiteMinder Policy Store DSA JSON payload
	* by default, it uses defdata to start building the payload
* smssjson -- outputs a sample SiteMinder Session Store DSA JSON payload
	* by default, it uses defdata to start building the payload
