# Directory Manager
This is the first release of the Symantec Directory Management
RestAPI framework published right after
the firt release of the "Symantec Directory dxagent RestAPI
Shell Script Framework" available at
"https://community.broadcom.com/enterprisesoftware/viewdocument/symantec-directory-dxagent-restapi".

To prepare the integration of the two frameworks after this
release, this zip file purposely include both frameworks
in a single package.
It is worth noting that both frameworks have adopted the git
version control. However, they are managed separately.

After the publish of this framework, a series of articles
will be published on the https://community.broadcom.com to share
the ideas behind this framework and the examples on how it 
can be utilized.

* Purposes

This first release of the Directory Manager RestAPI framework
focuses on using the restapis to help automating the
creation of multiple Router DSAs and DATA DSAs that
have the mult-write configured as manual attempts for
the tasks are tedious and error-prone.

Many features of the Directory Manager RestAPI have not
yet explored. You are welcome to send us emails to suggest
how you may want to see those features being used. For now,
you can send emails to yihhwa.cheng@broadcom.com.
Your inputs will be most appriciated.

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

