from pyspark import SparkConf, SparkContext
import sys

conf = SparkConf().setAppName("My App")
sc = SparkContext(conf = conf)

if len(sys.argv)<2 :
    print 'An input file is needed'
    sys.exit(2)
else:
    lines = sc.textFile(str(sys.argv[1]))
    words = lines.flatMap(lambda x: x.split(" "))
    result = words.map(lambda x: (x, 1)).reduceByKey(lambda x, y: x + y)
    extract= result.filter(lambda x:x[1]>2)
    for pair in extract.take(extract.count()):
        print(pair)
