FROM centos:7

ENV container docker
MAINTAINER "EvgenB" <evgen@ievgen.ru>

#Environment Variables
# from https://github.com/maaydin/kafka-docker/blob/master/docker/Dockerfile
#ENV HTTP_PROXY="http://172.17.0.1:3128" HTTPS_PROXY="http://172.17.0.1:3128"
ENV SCALA_VERSION="2.11" KAFKA_VERSION="0.10.0.0"

ADD start-kafka.sh /usr/bin/start-kafka.sh

# to systemd https://hub.docker.com/r/centos/systemd/~/dockerfile/
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

#Install Oracle JDK, ssh

RUN yum -y install java-1.8.0-openjdk.x86_64 openssh-server; yum clean all; systemctl enable sshd.service

# Install Kafka
RUN curl -v -o /tmp/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz https://archive.apache.org/dist/kafka/0.10.0.0/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz; \
cd /opt/ && tar -xzvf /tmp/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz; \
ln -s /opt/kafka_$SCALA_VERSION-$KAFKA_VERSION /opt/kafka; \
chmod +x /usr/bin/start-kafka.sh; 
#yum clean all; 
#rm -f /tmp/*; 

#Clean up
RUN yum clean all
RUN rm -fR /tmp/*;

VOLUME [ "/sys/fs/cgroup" ]

EXPOSE 22 80 9092

#CMD ["/usr/bin/start-kafka.sh"]

CMD ["/usr/sbin/init"]