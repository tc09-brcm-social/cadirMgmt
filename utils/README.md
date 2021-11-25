# utils
* authn.sample.temp -- template used to create authn
* curlver.sh -- output the version of curl in short format
* env.shlib -- information used by makeauthn.sh
* bash utils/getstarted.sh -- attempts to prepare the environment
	* ready to run
* bash utils/makeauthn.sh -- uses the authn.sample.temp
	* and utils/env.shlib to create authn
* setkeyvalue.sh FILENAME KEY VALUE -- set KEY=VALUE in a file
* setkeyifvalue.sh FILENAME KEY VALUE -- set KEY=VALUE in a file
	* when the value is not empty
