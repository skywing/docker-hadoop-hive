#!/bin/bash

echo "set tez version"
export TEZ_VERSION=0.9.2

echo "adding tez libs hadoop"
hadoop fs -mkdir -p /apps/tez
hadoop fs -copyFromLocal ${TEZ_LIB_DIR}/*.jar /apps/tez/
hadoop fs -copyFromLocal ${TEZ_LIB_DIR}/lib/*.jar /apps/tez/


echo "update hadoop classpath for hiveserver2"
export HADOOP_CLASSPATH=${TEZ_LIB_DIR}/*:${HADOOP_CLASSPATH};
echo "hadoop classpath... ${HADOOP_CLASSPATH}"

echo "starting HiveServer2!"
${HIVE_HOME}/bin/hiveserver2 --hiveconf hive.server2.enable.doAs=false
