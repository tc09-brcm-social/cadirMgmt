# utils
* authn.sample.temp -- template used to create authn
* curlver.sh -- output the version of curl in short format
* env.shlib -- information used by makeauthn.sh
* bash utils/getstarted.sh -- attempts to prepare the environment
	* ready to run
	* getstarted.sh creates symbolic link to existing jq in
	* the PATH or attempt to download from official Web site.
	* It also invokes makesyms, intdxagent, makeauthn
* bash utils/makeauthn.sh -- uses the authn.sample.temp
	* and utils/env.shlib to create authn
* bash utils/makesyms.sh -- create symbolic links for
	* a few short cuts
* bash utils/intdxagent.sh -- check if cadirCurl exists
	* if so, help create symbolic link to the jq as well
* setkeyvalue.sh FILENAME KEY VALUE -- set KEY=VALUE in a file
* setkeyifvalue.sh FILENAME KEY VALUE -- set KEY=VALUE in a file
	* when the value is not empty
