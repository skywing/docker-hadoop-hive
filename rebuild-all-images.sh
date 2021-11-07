#!/bin/bash

echo "Removing image with label platform=dev-hadoop-hive..."
docker rmi $(docker images --filter="label=platform=dev-hadoop-hive")
echo "Removing image done."

echo "Building hadoop base image..."
cd ./hadoop-base
docker build --no-cache -t hadoop-base:latest .
echo "Done."

echo "Building hadoop core image..."
cd ../hadoop-core
docker build --no-cache -t hadoop-core:latest .
echo "Done."

echo "Building hadoop name node image..."
cd ../hadoop-namenode
docker build --no-cache -t hadoop-namenode:latest .
echo "Done."

echo "Building hadoop data node image..."
cd ../hadoop-datanode
docker build --no-cache -t hadoop-datanode:latest .
echo "Done."

echo "Building hadoop resource manager image..."
cd ../hadoop-resourcemanager
docker build --no-cache -t hadoop-resourcemanager:latest .
echo "Done."

echo "Building hadoop node manager image..."
cd ../hadoop-nodemanager
docker build --no-cache -t hadoop-nodemanager:latest .
echo "Done."

echo "Building hadoop history server image..."
cd ../hadoop-historyserver
docker build --no-cache -t hadoop-historyserver:latest .
echo "Done."

echo "Building hive base image..."
cd ../hadoop-hive-base
docker build --no-cache -t hadoop-hive-base:latest .
echo "Done."

echo "Building hive server image..."
cd ../hadoop-hiveserver
docker build --no-cache -t hadoop-hiveserver:latest .
echo "Done."

echo "Building hive metastore image..."
cd ../hadoop-hive-metastore
docker build --no-cache -t hadoop-hive-metastore:latest .
echo "Done."

echo "Building hive metastore database (Postgres database) image..."
cd ../hadoop-hive-metastore-db
docker build --no-cache -t hadoop-hive-metastore-db:latest .
echo "Done."

echo "Building Python edge node image..."
cd ../hadoop-edgenode
docker build --no-cache -t hadoop-edgenode:latest .
echo "Done."
