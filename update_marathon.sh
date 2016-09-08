#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Necesita que le pasemos un fichero json como argumento"
  exit 1;
fi

JOBNAME=`grep -e  "\"id\"" linpack_marathon.json | sed -e 's/^.*\"\/\(.*\)\",$/\1/'`
echo $JOBNAME

curl -i -L -H 'Content-Type: application/json' -X PUT -d@"$@" 158.42.104.229:8080/v2/apps/$JOBNAME?force=true





