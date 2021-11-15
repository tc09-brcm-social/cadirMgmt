# samples/smuserjson
This sample outputs a sample SiteMinder LDAP user directory DSA object.
It starts with a default data JSON object.
The output of this sample can be used to make a template
and then to create a DSA.
* env.shlib -- for custom PREFIX, DBSIZE and the default data JSON
* make.sh -- to output
* user.ldif.temp PREFIX DEFPASSWORD -- a sample user data ldif template
	* PREFIX is an optional prefix to be appended to all entries
	* DEFPASSWORD is to provide a password to all entries 
		* usually for testing purpose
