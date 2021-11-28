# Directory Manager
* Pre-requisites
	* In addition to the bash and other common shell utilities,
	* this framework requires git and jq to operate correctly.
	*
	* jq needs to be made available under the home directory,
	* git just needs to be available similar to other utilities.
* Getting Started
	* Modify the utils/env.shlib to provide
	* the ADMINID, ADMINPASS, MANAGERHOST, MANAGERPORT
	*
	* bash utils/getstarted.sh
	*
	* to use the utils/env.shlib setting to create the
	* Authentication Module authn.
	* The authn is needed to provide the authentication
	* credential to connect to the designated
	* Directory Manager.
	*
	* After the getstarted, see Self Registration below.
	*
* Self Registration
	* samples/selfreg contains a self registration sample
	* script. See the samples/selfreg/README.md for details.
