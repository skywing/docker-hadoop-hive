#!/bin/bash

echo "Starting Hive Metastore!"

${HIVE_HOME}/bin/hive --service metastore
