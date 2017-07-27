#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Necesita que le pasemos un fichero json como argumento"
  exit 1;
fi

source vars.sh
curl -u $MARPRINCIPAL:$MARSECRET -i -L -H 'Content-Type: application/json' -X POST -d@"$@" 	$MESOSCLUSTER:$MARATHONPORT/v2/apps?force=true


