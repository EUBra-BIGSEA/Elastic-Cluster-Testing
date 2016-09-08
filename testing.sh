#!/bin/bash


echo "Tests for the EUBRA-BIGSEA environment"
echo "Set the next variables in vars.sh"
echo "MESOSCLUSTER Variable to the appropriate endpoint"
echo "HDFSHOMEDIR to your HDFS home directory before starting"
read -t5 -n1 -r -p 'Press any key in the next five seconds or ctrl-c the script if configuration is missing...' key

set -x

###### CHRONOS #######
echo "############ Chronos tests #############"
./chronos_test.sh
sleep $PAUSETIME


###### MARATHON #######
echo "############ Marathon tests #############"
./marathon_test.sh
sleep $PAUSETIME

###### HDFS & Mapreduce ######
echo "############ HDFS and MapReduce tests #############"
./hdfs_test.sh
sleep $PAUSETIME

###### Spark Tests
echo "############ Spark job via spark-submit, with no interaction with HDFS"
./spark_test.sh


