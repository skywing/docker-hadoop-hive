#!/bin/sh

docker-compose down --remove-orphans --volumes
docker rmi $(docker images --filter="label=dc-image=dev-edgenode")
