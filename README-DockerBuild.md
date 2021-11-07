
# Docker Build Sequence
1. hadoop-base
2. hadoop-core
3. hadoop-namenode
4. hadoop-datanode
5. hadoop-resourcemanager
6. hadoop-nodemanager
7. hadoop-historyserver (optional if you disable timeline server)
8. hadoop-hive-base (2 options to build depends on your need)
    - Build with one Dockerfile with multi-stage
    - Build with Dockerfile.tezbuilder first and Dockerfile.hivebase second
9. hadoop-hiveserver
10. hadoop-hive-metastore
11. hadoop-hive-metastore-db
12. hadoop-edgenode

# Rebuild all Docker image
```bash
./rebuild-all-images.sh
```
# Cleaning up Docker
You can easily delete previously download images for these examples with the following command:

```bash
docker images -a | grep "dev-hadoop-hive" | awk '{print $3}' | xargs docker rmi -f
```
or, for a complete system prune (this is what I usually do):
```bash
docker system prune -a -f --volumes --filter "label=platform=dev-hadoop-hive"
```
Remove all stopped containers:
```bash
docker ps -aq --no-trunc -f status=exited | xargs docker rm
```
Remove all dangling images:
```bash
docker images -q --filter dangling=true | xargs docker rmi
```
