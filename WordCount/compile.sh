#!/bin/bash

program=`echo $1 | awk -F "." '{print $1}'`

if [ ! -d "${program}_classes" ]
    then    mkdir ${program}_classes/;
fi


HADOOP_PATH=/opt/hadoop

HADOOP_CLASSES=/opt/hadoop-2.7.2/etc/hadoop:/opt/hadoop-2.7.2/share/hadoop/common/lib/*:/opt/hadoop-2.7.2/share/hadoop/common/*:/opt/hadoop-2.7.2/share/hadoop/hdfs:/opt/hadoop-2.7.2/share/hadoop/hdfs/lib/*:/opt/hadoop-2.7.2/share/hadoop/hdfs/*:/opt/hadoop-2.7.2/share/hadoop/yarn/lib/*:/opt/hadoop-2.7.2/share/hadoop/yarn/*:/opt/hadoop-2.7.2/share/hadoop/mapreduce/lib/*:/opt/hadoop-2.7.2/share/hadoop/mapreduce/*:/contrib/capacity-scheduler/*.jar


javac -classpath $HADOOP_CLASSES -d ${program}_classes/ $1

jar -cvf ${program}.jar -C ${program}_classes/ .;
