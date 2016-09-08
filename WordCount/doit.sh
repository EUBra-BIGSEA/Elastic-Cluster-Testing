cd WordCount
hdfs dfs -mkdir $HDFSHOMEDIR/WordCount
hdfs dfs -copyFromLocal quijote.txt $HDFSHOMEDIR/WordCount
./compile.sh WordCount.java
hadoop jar WordCount.jar org.apache.hadoop.examples.WordCount $HDFSHOMEDIR/WordCount/quijote.txt $HDFSHOMEDIR/WordCount/output
cd ..
