#!/bin/bash
if [ -f .env ]; then
    source .env
fi

docker stop kafka
docker rm -f kafka

sleep 2

#docker run --privileged --name kafka -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 9092:9092 -d  kafka
docker run --privileged --name kafka -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 2223:22 -p 8080:80 -p 9092:9092 kafka

