# Docker Hadoop - Edge node with Python 3.8
Edge node for developer for python development that interact with the Hadoop Hive cluster.


`Dockerfile` responsible for installing and configuring the edge node server. It is the baseline image that the derive project will need to extend to mount the proper code volume into this image.

## Building the Image
```bash
docker build --no-cache -t hadoop-edgenode:latest .
```

## Running the Image
This is a base edge node server image used by developer to derive and mount the code directory for development and testing.

