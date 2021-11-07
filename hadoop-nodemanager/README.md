# Docker Hadoop - Node manager

`Dockerfile` responsible for installing and configuring the hadoop node manager.

## Node Manager
The NodeManager is responsible for launching and managing containers on a node. Containers execute tasks as specified by the AppMaster.

## Building the Image
```bash
docker build --no-cache -t hadoop-nodemanager:latest .
```

## Running the Image
This should be run as part of the `docker-compose.yml`

