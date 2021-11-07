#!/bin/bash

if [ -d "/tmp/hadoop-root/dfs/name/current" ]; then
    echo "Namenode formatted!"
else
    echo "Formatting Namenode!"
    ${HADOOP_HOME}/bin/hdfs --config ${HADOOP_CONF_DIR} namenode -format ${CLUSTER_NAME}
fi

echo "Starting Namenode!"
${HADOOP_HOME}/bin/hdfs --config ${HADOOP_CONF_DIR} namenode
