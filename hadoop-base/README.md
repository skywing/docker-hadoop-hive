# Docker Hadoop - Base Image

`Dockerfile` responsible for installing and configuring Hadoop base image.  This image is extended by a `hadoop-core`.

This image does the following:
* update image timezone to `America/New_York`
* run `yum install -y` update and install the following required packages:
    * `java-1.8.0-openjdk`
    * `java-1.8.0-openjdk-devel`
    * `perl`
    * `nc`
* add `entrypoint.sh`

## Building the Image
```bash
docker build --no-cache -t hadoop-base:latest .
```

## Running the Image
This is a base image and not suitable to run as standalone.

# Hadoop Configuration
`entrypoint.sh` will update the following hadoop configuration files based on the `*.env` files
* core.env
* hive.env
* metastore.env
* yarn-node-manager.env
* yarn-remote.env
* yarn-resource-manager.env
* yarn-timeline.env 
