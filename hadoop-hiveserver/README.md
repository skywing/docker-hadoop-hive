# Docker Hadoop - Hive Server 2

`Dockerfile` responsible for launching HiverServer2.

HiveServer2 (HS2) is a service that enables clients to execute queries against Hive. HiveServer2 is the successor to HiveServer1 which has been deprecated. HS2 supports multi-client concurrency and authentication. It is designed to provide better support for open API clients like JDBC and ODBC.

HS2 is a single process running as a composite service, which includes the Thrift-based Hive service (TCP or HTTP) and a Jetty web server for web UI. 

## Shell Script to Setup Tez Java Class Path
In order for Apache Tez to run correctly, 
- Copy Tez libraries to HDFS
```bash
hadoop fs -mkdir -p /apps/tez
hadoop fs -copyFromLocal ${TEZ_LIB_DIR}/*.jar /apps/tez/
hadoop fs -copyFromLocal ${TEZ_LIB_DIR}/lib/*.jar /apps/tez/
```

- Setup hadoop class path with Tez libraries
```bash
export HADOOP_CLASSPATH=${TEZ_LIB_DIR}/*:${HADOOP_CLASSPATH};
```

## Building the Image
```bash
docker build --no-cache -t hadoop-hiveserver:latest .
```

## Running the Image
This should be run as part of the `docker-compose.yml`
