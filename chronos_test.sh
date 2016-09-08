#!/bin/bash

set -x
source vars.sh

echo "##### Simple job, job embedded in the command argument" 
echo "# Submission of the framework"
curl -L -H 'Content-Type: application/json' -X POST -d '{ "schedule": "R5/2016-06-01T07:15:00Z/PT2S", "name": "BIGSEA_simpletest", "epsilon": "PT15M", "command": "echo 'Run' >> /tmp/simple_test.out", "owner": "iblanque@dsic.upv.es", "async": false }' $MESOSCLUSTER:$CHRONOSPORT/scheduler/iso8601
echo "# Run job"
curl -L -X PUT $MESOSCLUSTER:$CHRONOSPORT/scheduler/job/BIGSEA_simpletest

sleep $PAUSETIME


echo "##### Simple container job, job embedded in the command argument and no volumes" 
echo "# Submission of the framework"
curl -L -H 'Content-Type: application/json' -X POST -d '{ "schedule": "R5/2016-06-01T07:45:00Z/PT2S", "name": "BIGSEA_dockertest", "container": { "type": "DOCKER", "image": "ubuntu", "network": "BRIDGE" }, "cpus": "0.5", "mem": "512", "uris": [], "command": "while sleep 10; do date =u %T; done" }' $MESOSCLUSTER:$CHRONOSPORT/scheduler/iso8601
echo "# Run job"
curl -L -X PUT $MESOSCLUSTER:$CHRONOSPORT/scheduler/job/BIGSEA_dockertest

sleep $PAUSETIME

echo "##### Container-specific job, containers mounts a volume from the shared directory where data and executable files are found"
echo "# Submission of the framework"
curl -i -L -H 'Content-Type: application/json' -X POST -d@"container_job_volume.json" $MESOSCLUSTER:$CHRONOSPORT/scheduler/iso8601
echo "# Run job"
curl -L -X PUT $MESOSCLUSTER:$CHRONOSPORT/scheduler/job/docker_volume

sleep $PAUSETIME

echo "##### Long-time executing container job that runs the linpack benchmark several times. Used to test vertical elasticity"
echo "# Submission of the framework"
curl -i -L -H 'Content-Type: application/json' -X POST -d@"linpack.json" $MESOSCLUSTER:$CHRONOSPORT/scheduler/iso8601
echo "# Run job"
curl -L -X PUT $MESOSCLUSTER:$CHRONOSPORT/scheduler/job/linpack_test
echo "# It will long for a while. You can change the allocation of resources with the following command:"
echo "curl -i -L -H 'Content-Type: application/json' -X POST -d@\"linpack_scaled.json\" $MESOSCLUSTER:$CHRONOSPORT/scheduler/iso8601"


