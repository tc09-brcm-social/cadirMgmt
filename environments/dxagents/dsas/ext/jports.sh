#!/bin/bash
MYPATH=$(dirname "$0")
./jq \
    '[.config.knowledge[]
      | { name: .name,
          "console-port": ."console-port",
          "interface": ."interface",
          "remote-console-port": ."remote-console-port"
        }
     ]'
