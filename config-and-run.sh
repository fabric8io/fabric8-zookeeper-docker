#!/bin/bash

# Persists the ID of the current instance of Zookeeper
echo ${SERVER_ID} > /opt/zookeeper/data/myid

exec /opt/zookeeper/bin/zkServer.sh start-foreground
