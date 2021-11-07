# Docker Hadoop - History server

`Dockerfile` responsible for installing and configuring the hadoop history server.

## History Server
JobTracker or ResourceManager keeps all job information in memory. For finished jobs, it drops them to avoid running out of memory. Tracking of these past jobs are delegated to JobHistory server. 

## Building the Image
```bash
docker build --no-cache -t hadoop-historyserver:latest .
```

## Running the Image
This should be run as part of the `docker-compose.yml`

