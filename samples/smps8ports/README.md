# samples/smps8ports
This is a simple env.shlib manipulation for the smps1 sample.
It modify the smps1/env.shlib in such a way 8 consecutive ports will
be used by the smps1 sample.

smps DSAs is referring to the 4 DSAs, router, policy store, session
store, and user store DSAs.

A typical use case is to use this to help create multiple
independent sets of smps DSAs. You can keep different copies
of the env.shlib so that you can quickly bring one of them
in place and go to the samples/smps1 to perform desired
operations against that set of smps DSAs.
* env.shlib
	* INST set it to an "instance number" that is unique across multiple
		sets of smps DSAs you want to use
	* DXANAME set to adxagent exists in the registrar
		the smps DSAs are to be created off that DXAgent
	* PORT set to a unique port number across all sets of smps DSAs
		PORT + 1, ... PORT + 8 will be used
* "bash make.sh" only modify the smps1/env.shlib.
	* go to smps1 to perform the desired operations after.
