#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Necesita que le pasemos un fichero json como argumento"
  exit 1;
fi

curl -i -L -H 'Content-Type: application/json' -X POST -d@"$@" 	158.42.104.229:8080/v2/apps?force=true


