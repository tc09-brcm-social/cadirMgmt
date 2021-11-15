#!/bin/bash
NAME=$1
VALUE=$2
if [[ -z "$NAME" ]]; then
   if [[ -z "$VALUE" ]]; then
      cat
      exit 1
   else
      ./jq -S ".config.settings = ${VALUE}"
   fi
else 
   ./jq -S ".config.settings.\"${NAME}\" = ${VALUE}"
fi
