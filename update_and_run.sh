#!/bin/sh

set -ei

folder="oozie-workflow"
OOZIE_URL="http://namenode002:11000/oozie"
upload_dir="/user/admin/workflows/"

export $OOZIE_URL


echo "Updating $folder"

# Validate workflows
oozie validate "$folder/workflow.xml"

# Delete old files
HADOOP_USER_NAME=hdfs hadoop fs -mkdir -p "$upload_dir/"
HADOOP_USER_NAME=hdfs hadoop fs -rm -r -f -skipTrash "$upload_dir/$folder"

# Copy to HDFS
HADOOP_USER_NAME=hdfs hadoop fs -copyFromLocal -f "$folder" "$upload_dir/"

# Run job
oozie job -config "$folder/coordinator.properties" -run
