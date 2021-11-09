# environments/dxagents/dsas/ext
* makeauthn.sh envName dxaName baseFilename tempFile optionalDir -- write
	* the client PEM and key files using the baseFilename
	* to the optionalDir. Default optionDir is '.'. 
	* use the tempFile host port and baseFilename to
	* output the dxagent authentication file
