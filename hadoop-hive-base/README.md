# Docker Hadoop - Hive base

`Dockerfile` responsible for installing and configuring the hadoop hive image.  This image is extended by other Hadoop docker image projects.

## Hive
The Apache Hive ™ data warehouse software facilitates reading, writing, and managing large datasets residing in distributed storage using SQL. Structure can be projected onto data already in storage. A command line tool and JDBC driver are provided to connect users to Hive.

### Execution engine changes
Apache Tez replaces MapReduce as the default Hive execution engine. MapReduce is no longer supported, and Tez stability is proven. With expressions of directed acyclic graphs (DAGs) and data transfer primitives, execution of Hive queries under Tez improves performance. SQL queries you submit to Hive are executed as follows:

- Hive compiles the query.
- Tez executes the query.
- YARN allocates resources for applications across the cluster and enables authorization for Hive jobs in YARN queues.
- Hive updates the data in HDFS or the Hive warehouse, depending on the table type.
- Hive returns query results over a JDBC connection.

## Tez Configuration
The following setting in the tez-site.xml in order for Tez to locate its libraries and dependencies.
```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>tez.lib.uris</name>
        <value>${fs.defaultFS}/apps/tez/</value>
    </property>
    <property>
        <name>tez.use.cluster.hadoop-libs</name>
        <value>true</value>
    </property>
</configuration>
```

## Building the Image
```bash
docker build --no-cache -t hadoop-hive-base:latest .
```

## Tez builder
The `Dockerfile` is a multistage image build started with building Tez using maven to compile protobuf with GCC. It takes a while to build. To reduce the time for repeatable building hive base image, a `Dockerfile.tezbuilder` is created to build an image that can be reused later.
```bash
docker build --no-cache -t tez-builder:0.9.2 -f Dockerfile.tezbuilder .
```

## Hive builder
`Dockerfile.hivebase` is the second stage of the multi-stage build. This file is create so it use the tez-builder:0.9.2 image instead of building tez and protobuf from scratch.
```bash
docker build --no-cache -t hadoop-hive-base:latest -f Dockerfile.hivebase .
```
