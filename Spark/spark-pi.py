#!/usr/bin/python

import sys, random
from pyspark import SparkConf, SparkContext

if len(sys.argv)<2 :
    NUM_SAMPLES=100000
else:
    NUM_SAMPLES=int(sys.argv[1])

conf = SparkConf().setAppName("My PI Spark app")
sc = SparkContext(conf = conf)
def sample(p):
    x, y = random.random(), random.random()
    return 1 if x*x + y*y < 1 else 0

count = sc.parallelize(xrange(0, NUM_SAMPLES)).map(sample) \
             .reduce(lambda a, b: a + b)
print "Pi is roughly %f" % (4.0 * count / NUM_SAMPLES)


