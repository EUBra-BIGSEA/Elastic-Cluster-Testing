#!/bin/bash

set -x

echo "Tests for the EUBRA-BIGSEA environment"
echo "Set the MESOSCLUSTER Variable to the appropriate endpoint"

MESOSCLUSTER=158.42.104.229
HDFSINTERNAL=10.0.0.67
HDFSPORT=9000
MESOSPORT=5050
CHRONOSPORT=4400
MARATHONPORT=8080

PAUSETIME=5

echo "set HDFSHOMEDIR to your HDFS home directory before starting"
read -t5 -n1 -r -p 'Press any key in the next five seconds or ctrl-c the script if configuration is missing...' key

HDFSHOMEDIR=/users/ubuntu



###### CHRONOS #######

echo "############ Chronos tests #############"

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

###### MARATHON #######

echo "############ Marathon tests #############"

echo "##### Simple job, no containers"
echo "# Submission and execution of the framework"
curl -i -L -H 'Content-Type: application/json' -X POST -d@"marathon_simple.json" $MESOSCLUSTER:$MARATHONPORT/v2/apps

sleep $PAUSETIME

echo "##### Simple job, with containers"
echo "# Submission and execution of the framework"
curl -i -L -H 'Content-Type: application/json' -X POST -d@"marathon_docker_simple.json" $MESOSCLUSTER:$MARATHONPORT/v2/apps

sleep $PAUSETIME

###### HDFS & Mapreduce ######
echo "############ HDFS and MapReduce tests #############"
echo "##### Copy WordCount data and program, compile and run it"

cd WordCount
hdfs dfs -mkdir $HDFSHOMEDIR/WordCount
hdfs dfs -copyFromLocal quijote.txt $HDFSHOMEDIR/WordCount
./compile.sh WordCount.java
hadoop jar WordCount.jar org.apache.hadoop.examples.WordCount $HDFSHOMEDIR/WordCount/quijote.txt $HDFSHOMEDIR/WordCount/output
cd ..

###### Spark Tests
echo "############ Spark job via spark-submit, with no interaction with HDFS"
echo "##### Compute an approximation of Pi in python"
cd Spark
spark-submit --executor-memory 256M --num-executors 1 --master mesos://$MESOSCLUSTER:$MESOSPORT spark-pi.py

echo "############ Spark job via spark-submit, with interaction with HDFS"
echo "##### Compute wordcount with Spark"
hdfs dfs -copyFromLocal palabras.txt $HDFSHOMEDIR/WordCount
spark-submit --executor-memory 256M --num-executors 1 --master mesos://$MESOSCLUSTER:$MESOSPORT wc_spark.py hdfs://$HDFSINTERNAL:$HDFSPORT$HDFSHOMEDIR/WordCount/palabras.txt

echo "############ Spark execution via spark-shell, without interaction with HDFS"
echo "##### Compute an approximation of Pi in python"

spark-shell --executor-memory=256M --master mesos://$MESOSCLUSTER:$MESOSPORT <spark_pi.scala
cd ..

######### TESTING

#if [ `curl -L -X GET $MESOSCLUSTER:$CHRONOSPORT/scheduler/jobs | lastError.sh BIGSEA_simpletest ` -neq "" ] 
#  echo "Error running simple job"
#  exit(1)
#else
#  echo "Simple job successful"
#fi



