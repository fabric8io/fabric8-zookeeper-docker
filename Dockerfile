FROM java

MAINTAINER iocanel@gmail.com

RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-3.4.6 /opt/zookeeper \
    && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
    && mkdir -p /tmp/zookeeper

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

EXPOSE 2181 2888 3888

ADD config-and-run.sh /opt/zookeeper/bin/
ADD zoo-common.cfg /opt/zookeeper/conf/

WORKDIR /opt/zookeeper

ENTRYPOINT ["/opt/zookeeper/bin/config-and-run.sh"]
CMD ["start-foreground"]
