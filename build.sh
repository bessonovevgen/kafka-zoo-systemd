#!/bin/bash
if [ -f .env ]; then
    source .env
fi

docker stop kafka
docker rm -f kafka

#pushd ./kafka-docker/docker/
#docker build -t kafka-docker .
#popd


docker build -t kafka .

sleep 2

docker rmi $(docker images | grep "^<none>" | awk '{print $3}')

