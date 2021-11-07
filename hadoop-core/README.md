# Docker Hadoop - Core (Hadoop 2.10.1)

`Dockerfile` responsible for installing and configuring the core Hadoop image.  This image is extended by other docker hadoop image projects. All Java log4j configuration files are in `conf` folder.

## Building the Image
```bash
docker build --no-cache -t hadoop-core:latest .
```

## Running the Image
This is a core image used by other Hadoop node and not suitable to run as standalone.

