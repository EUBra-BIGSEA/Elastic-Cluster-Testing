#!/bin/bash

source vars.sh

echo "##### Compute an approximation of Pi in python"
cd Spark
spark-submit --executor-memory 256M --num-executors 1 --master mesos://$MESOSCLUSTER:$MESOSPORT spark-pi.py

echo "############ Spark job via spark-submit, with interaction with HDFS"
echo "##### Compute wordcount with Spark"
hdfs dfs -copyFromLocal palabras.txt $HDFSHOMEDIR/WordCount
spark-submit --executor-memory 256M --num-executors 1 --master mesos://$MESOSCLUSTER:$MESOSPORT wc_spark.py hdfs://$HDFSINTERNAL:$HDFSPORT$HDFSHOMEDIR/WordCount/palabras.txt

sleep $PAUSETIME


echo "############ Spark execution via spark-shell, without interaction with HDFS"
echo "##### Compute an approximation of Pi in python"

spark-shell --executor-memory=256M --master mesos://$MESOSCLUSTER:$MESOSPORT <spark_pi.scala
cd ..

