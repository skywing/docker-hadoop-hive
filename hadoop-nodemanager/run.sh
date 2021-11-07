#!/bin/bash

echo "Starting nodemanager!"
${HADOOP_HOME}/bin/yarn --config ${HADOOP_CONF_DIR} nodemanager

