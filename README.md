docker build --rm --no-cache -t kafka .

docker run --privileged --name kafka -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 2223:22 -p 8080:80 -p 9092:9092 -d kafka

