# Docker Hadoop - Local Development with Hadoop 2.10.1 Cluster
Inspired by the work of [Tim Veil](https://github.com/timveil) dockerize Hadoop, a baseline Hadoop docker container that align to [AWS EMR version](https://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-release-5x.html) is developed to support hadoop local and end to end development and python debugging.


The `docker-compose.yml` contains the following services:
* `namenode` - Apache Hadoop NameNode
* `datanode` - Apache Hadoop DataNode
* `resourcemanager` - Apache Hadoop YARN Resource Manager
* `nodemanager` - Apache Hadoop YARN Node Manager
* `historyserver` - Apache Hadoop YARN Timeline Manager
* `hs2` - Apache Hive HiveServer2
* `metastore` - Apache Hive Metastore
* `metastore-db` - Postgres DB that supports the Apache Hive Metastore

## Configuration
Hadoop configuration parameters are provided by the following `.env` files.  Ultimately these values are written to the appropriate Hadoop XML configuration file.  For Example, properties beginning with the following keys map the following files:
* `CORE_CONF_*` > `core-site.xml`
* `HDFS_CONF_*` > `hdfs-site.xml`
* `HIVE_SITE_CONF_*` > `hive-site.xml`
* `YARN_CONF_*` > `yarn-site.xml`

Key names use the following character conversions:
* a single underscore `_` equals dot `.`
* a double underscore `__` equals a single underscore `_`
* a triple underscore `___` equals a dash `-`

For example, the key `HDFS_CONF_dfs_namenode_datanode_registration_ip___hostname___check` would result in the property `dfs.namenode.datanode.registration.ip-hostname-check` being written to `hdfs-site.xml`.

Another example, the key `YARN_CONF_yarn_resourcemanager_resource__tracker_address` would result in the property `yarn.resourcemanager.resource_tracker.address` being written to `yarn-site.xml`.

Exiting configuration files and their default values are listed below.  Please note the value for `YARN_CONF_yarn_nodemanager_resource_memory___mb` assumes that your docker host has at least 8gb of memory.  Feel free to modify as necessary. 

### core.env
```properties
HADOOP_LOG_DIR=/var/log/hadoop
YARN_LOG_DIR=/var/log/hadoop

CORE_CONF_fs_defaultFS=hdfs://namenode:8020
CORE_CONF_hadoop_http_staticuser_user=root

HDFS_CONF_dfs_namenode_datanode_registration_ip___hostname___check=false
HDFS_CONF_dfs_permissions_enabled=false
HDFS_CONF_dfs_webhdfs_enabled=true
HDFS_CONF_dfs_replication=1

MAPRED_CONF_mapreduce_framework_name=yarn

YARN_CONF_yarn_nodemanager_resource_memory___mb=8096
YARN_CONF_yarn_nodemanager_aux___services=mapreduce_shuffle
YARN_CONF_yarn_nodemanager_aux___services_mapreduce__shuffle_cs=org.apache.hadoop.mapred.ShuffleHandler
# This will disable the virtual vs physical memory check. If not disable, YARN will kill the container if the process used more than the limit of virtual memory
YARN_CONF_yarn_nodemanager_vmem___check___enabled=false

YARN_CONF_yarn_resourcemanager_recovery_enabled=true
YARN_CONF_yarn_resourcemanager_store_class=org.apache.hadoop.yarn.server.resourcemanager.recovery.FileSystemRMStateStore
YARN_CONF_yarn_resourcemanager_system___metrics___publisher_enabled=true
YARN_CONF_yarn_resourcemanager_hostname=resourcemanager
YARN_CONF_yarn_resourcemanager_address=resourcemanager:8032
YARN_CONF_yarn_resourcemanager_scheduler_address=resourcemanager:8030
YARN_CONF_yarn_resourcemanager_resource___tracker_address=resourcemanager:8031
# Timeline service is disabled to reduce the number of running container to support the development.
YARN_CONF_yarn_timeline___service_enabled=false
YARN_CONF_yarn_timeline___service_generic___application___history_enabled=false
YARN_CONF_yarn_scheduler_capacity_root_default_maximum___am___resource___percent=0.1

```

### hive.env
```properties
HIVE_SITE_CONF_javax_jdo_option_ConnectionURL=jdbc:postgresql://metastore-db/metastore
HIVE_SITE_CONF_javax_jdo_option_ConnectionDriverName=org.postgresql.Driver
HIVE_SITE_CONF_javax_jdo_option_ConnectionUserName=hive
HIVE_SITE_CONF_javax_jdo_option_ConnectionPassword=hive
HIVE_SITE_CONF_hive_server2_transport_mode=binary
HIVE_SITE_CONF_hive_execution_engine=tez
HIVE_SITE_CONF_datanucleus_schema_autoCreateAll=false
HIVE_SITE_CONF_hive_metastore_uris=thrift://metastore:9083
HIVE_SITE_CONF_hive_log_explain_output=true
HIVE_SITE_CONF_hive_server2_enable_doAs=true
```

### yarn-node-manager.env
```properties
YARN_CONF_yarn_resourcemanager_resource___tracker_address=resourcemanager:8031
```

### yarn-remote.env
```properties
```

### yarn-resource-manager.env
```properties
```

### yarn-timeline.env
```properties
```

## Docker Compose

### Start the Containers
```bash
docker-compose up -d
```
or in the docker-hadoop directory 
```bash
./start.sh
```

### Stop and Destroy the Containers
```bash
docker-compose down
```
or in the docker-hadoop directory 
```bash
./down.sh
```
## Testing
Once all services are up you can create a simple hive table to test functionality.  For example:

```bash
$ docker-compose exec hs2 bash
# /opt/hive/bin/beeline -u jdbc:hive2://localhost:10000
> CREATE TABLE pokes (foo INT, bar STRING);
> LOAD DATA LOCAL INPATH '/opt/hive/examples/files/kv1.txt' OVERWRITE INTO TABLE pokes;
> SELECT * FROM pokes; -- This Hive query will not start the Tez DAG process
> ANALYZE TABLE pokes COMPUTE STATISTICS; -- Without this statement, the count will return empty
> SELECT count(*) FROM pokes; -- This Hive query will start the Tez DAG process to test the Tez and YARN setup
> !quit
```

## Exposed UI Interfaces

* Name Node Overview - http://localhost:50070
* Data Node Overview - http://localhost:50075
* YARN Resource Manager - http://localhost:8088
* YARN Node Manager - http://localhost:8042
* YARN Application History - http://localhost:8188
* HiveServer 2 - http://localhost:10002

## Docker Images
* Hadoop NameNode -> dev-namenode
* Hadoop DataNode -> dev-datanode
* YARN Resource Manager -> dev-resourcemanager
* YARN Node Manager -. dev-nodemanager
* YARN Timeline Server -> dev-historyserver
* Hive Hiverserver2 -> dev-hiveserver
* Hive Metastore -> dev-hive-metastore
* Hive Metastore Postgres DB -> dev-hive-metastore-db
* Edge node server -> dev-python38

## Open Interactive Shells
```bash
docker exec -ti namenode /bin/bash
docker exec -ti datanode /bin/bash
docker exec -ti resourcemanager /bin/bash
docker exec -ti nodemanager /bin/bash
docker exec -ti historyserver /bin/bash
docker exec -ti hs2 /bin/bash
docker exec -ti metastore /bin/bash
docker exec -ti metastore-db /bin/bash
docker exec -it edgenode /bin/bash
```
