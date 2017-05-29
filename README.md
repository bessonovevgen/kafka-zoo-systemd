docker build --rm --no-cache -t httpd .

docker run --privileged --name httpd -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 80:80 -d  httpd

