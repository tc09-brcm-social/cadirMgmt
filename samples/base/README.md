# base environment creation utility
The files under this subdirectory is used to help
creating a sample base Management UI environment that
can be used later for other purposes.
This base sample is best run on the Directory machine
right after the installation of the Directory Manager,
dxagent, and the dxserver on the same machine.
* make.sh -- create a base environment with the local dxagent on it
	* This is recommended to be run on a new Directory machine
	* right after the installation is done assuming both
	* the dxagent and Directory Manager are also installed
	* with the dxserver.
	* use ../env.shlib and ./envshlib to decide environment
	* and dxagent names.
	* defenv.shlib contains the PORT and HOSTName used to
	* create the defualt DSAs.
	* The default DATA and ROUTER DSAs is meant to help using
	* the default settings done using Directory Manager UI.
* makenvshlib.sh -- best attempt to help create the env.shlib
	* This is usually invoked by make.sh to help set
	* the env.shlib.
	* Both make.sh and makenvshlib.sh assumes your Directory is
	* installed under the default location.
	* Or you can set the DXHOME environment variable for this to work.
* defenv.shlib -- used to set the ports and ldaphost name if required
* env.shlib -- used to set local ENVNAME, DXAGENT, and DXACLIENT
	* DXACLIENT is the client name specified when installing the dxagent
	* DXACLIENT is used to compute the certificate file names.
* unmake.sh -- remove the defaul DSAs, both DATA and Routter,
	* the DXAGENT and then the Environment
