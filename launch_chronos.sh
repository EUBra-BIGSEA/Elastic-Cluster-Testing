#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Necesita que le pasemos un fichero json como argumento"
  exit 1;
fi

MESOSMASTER=158.42.104.229
curl -i -L -H 'Content-Type: application/json' -X POST -d@"$@" $MESOSMASTER:4400/scheduler/iso8601




