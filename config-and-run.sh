#!/bin/bash

function getKey() {
  echo $1 | cut -d "=" -f1
}

function getValue() {
  echo $1 | cut -d "=" -f2
}

function envValue() {
 local entry=`env | grep $1`
 echo `getValue $entry`
}

CLIENT_PORT=`envValue ZK_CLIENT_SERVICE_PORT`
cp conf/zoo-common.cfg conf/zoo.cfg
echo "clientPort=$CLIENT_PORT" >> conf/zoo.cfg

#Find the server id
SERVER_ID=`envValue ZK_SERVER_ID`
if [ ! -z "$SERVER_ID" ]; then
  echo "$SERVER_ID" > /opt/zookeeper/data/myid
  #Find the servers exposed in env.
  for i in `echo {1..15}`;do

    HOST=`envValue ZK_PEER_${i}_SERVICE_HOST`
    PEER=`envValue ZK_PEER_${i}_SERVICE_PORT`
    ELECTION=`envValue ZK_ELECTION_${i}_SERVICE_PORT`

    if [ "$SERVER_ID" = "$i" ];then
      echo "server.$i=0.0.0.0:2888:3888" >> conf/zoo.cfg
    elif [ -z "$HOST" ] || [ -z "$PEER" ] || [ -z "$ELECTION" ] ; then
      #if a server is not fully defined stop the loop here.
      break
    else 
      echo "server.$i=$HOST:$PEER:$ELECTION" >> conf/zoo.cfg
    fi

  done
fi

/opt/zookeeper/bin/zkServer.sh start-foreground
