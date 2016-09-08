#!/bin/bash

source vars.sh

echo "##### Simple job, no containers"
echo "# Submission and execution of the framework (use launch_marathon.sh)" 
curl -i -L -H 'Content-Type: application/json' -X POST -d@"marathon_simple.json" $MESOSCLUSTER:$MARATHONPORT/v2/apps

sleep $PAUSETIME

echo "##### Simple job, with containers"
echo "# Submission and execution of the framework"
curl -i -L -H 'Content-Type: application/json' -X POST -d@"marathon_docker_simple.json" $MESOSCLUSTER:$MARATHONPORT/v2/apps

sleep $PAUSETIME

echo "##### Linpack job, with containers"
echo "# Submission and execution of the framework"
curl -i -L -H 'Content-Type: application/json' -X POST -d@"linpack_marathon.json" $MESOSCLUSTER:$MARATHONPORT/v2/apps
echo "# Wait for the first execution to be completed (5 minutes)"

sleep 300

echo "# Add more CPU and memory (Use update_marathon.sh for that)"
curl -i -L -H 'Content-Type: application/json' -X PUT -d@"linpack_marathon_scaled.json"  $MESOSCLUSTER:$MARATHONPORT/v2/apps/product/service/linpackmartest?force=true





