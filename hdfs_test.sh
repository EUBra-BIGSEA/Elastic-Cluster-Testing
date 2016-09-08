#!/bin/bash

source vars.sh
echo "##### Copy WordCount data and program, compile and run it"

cd WordCount
hdfs dfs -mkdir $HDFSHOMEDIR/WordCount
hdfs dfs -copyFromLocal quijote.txt $HDFSHOMEDIR/WordCount
./compile.sh WordCount.java
hadoop jar WordCount.jar org.apache.hadoop.examples.WordCount $HDFSHOMEDIR/WordCount/quijote.txt $HDFSHOMEDIR/WordCount/output
cd ..

