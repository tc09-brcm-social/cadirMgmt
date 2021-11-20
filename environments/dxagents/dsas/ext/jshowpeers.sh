#!/bin/bash
cat | ./jq '{ "name": .name, "status": .status, "dsaPeers": .dsaPeers}'
