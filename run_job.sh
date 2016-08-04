#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Necesita que le pasemos un fichero json como argumento"
  exit 1;
fi


MESOSMASTER=158.42.104.229
JOBNAME=`grep name $@ | sed -e 's/^.*: \"\(.*\)\".*$/\1/'`
echo $JOBNAME
curl -L -X PUT $MESOSMASTER:4400/scheduler/job/$JOBNAME

