# samples
* env.shlib -- contains the sample-wise environment variables
	* as appropriate. See env.shilb for more deteails.
* base -- a sample that is used to create a base environment and dxagent
	* It is recommended to run this example on a new
	* Directory server right after the dxserver, dxagent, and
	* Directory Manager are installed.
* defdata -- to obtain the JSON object of the default DATA DSA
	* created by the base example.
* defrouter -- to obtain the JSON object of the default Router DSA
	* created by the base example.
* registrar -- to register an dxagent on the registrar environment
	* When there are multiple dxagent machines,
	* registering them on this same environment will make dxagent
	* connectivity information available for other environments.
* smuserjson -- outputs a sample SiteMinder User Directory DSA JSON payload
	* by default, it uses defdata to start building the payload
* smpsjson -- outputs a sample SiteMinder Policy Store DSA JSON payload
	* by default, it uses defdata to start building the payload
* smssjson -- outputs a sample SiteMinder Session Store DSA JSON payload
	* by default, it uses defdata to start building the payload
