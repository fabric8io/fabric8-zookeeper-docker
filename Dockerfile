FROM jboss/base-jdk:7

MAINTAINER iocanel@gmail.com

USER root
RUN yum -y install wget socat \
    && wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-3.4.6 /opt/zookeeper \
    && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
    && mkdir -p /opt/zookeeper/data \
    && mkdir -p /opt/zookeeper/log

ENV JAVA_HOME /usr/lib/jvm/java

EXPOSE 2181 2888 3888

ADD config-and-run.sh /opt/zookeeper/bin/
ADD zoo-common.cfg /opt/zookeeper/conf/

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/opt/zookeeper/data", "/opt/zookeeper/log"]

ENTRYPOINT ["/opt/zookeeper/bin/config-and-run.sh"]
CMD ["start-foreground"]
