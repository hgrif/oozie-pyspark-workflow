#!/bin/sh


set -ei

if [ $# -ne 2 ]
then
    echo "Not enough arguments supplied"
    exit 1
fi

export SPARK_HOME="/opt/cloudera/parcels/CDH/lib/spark"
# Note: Add the current dir in the Oozie container to PYTHON_PATH so Spark can
# use it (YMMV).
export PYTHONPATH="/opt/cloudera/parcels/CDH/lib/spark/python:/opt/cloudera/parcels/CDH/lib/spark/python/lib/py4j-0.9-src.zip:."
export PYSPARK_PYTHON="/opt/cloudera/parcels/Anaconda/bin/python"
export HADOOP_USER_NAME=admin

script=$1
date=$2

sleep 10  # Sleep a bit so that you can be quick enough to see get the log in Hue.

echo "Running in script $script; date $date"

spark-submit \
    --master yarn-client \
    --driver-memory=8g \
    --executor-memory=3g \
    # You may not need this:
    # Change .python-eggs folder because my user doesn't have a $HOME on the
    # cluster, resulting in PYTHON_EGG_CACHE errors on the executors.
    --conf spark.executorEnv.PYTHON_EGG_CACHE=/tmp/ \
    # Note that both the egg and the script are put in the base folder of the
    # Oozie container.
    --py-files=project-1.0-py3.5.egg
    "$script" "$date"
