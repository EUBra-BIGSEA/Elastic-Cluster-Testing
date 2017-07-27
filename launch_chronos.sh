#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Necesita que le pasemos un fichero json como argumento"
  exit 1;
fi

source vars.sh
curl -u $CHRPRINCIPAL:$CHRSECRET -i -L -H 'Content-Type: application/json' -X POST -d@"$@" $MESOSMASTER:$CHRONOSPORT/scheduler/iso8601




