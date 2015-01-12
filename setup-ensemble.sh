#!/bin/bash

function usage() {
  echo "Usage: setup-ensemble <<size>> <<docker host>>"
  exit 1
}

function server_run_str() {
  local ID=$1
  local SIZE=$2
  local HOST=$3
  MY_CLIENT_PORT=$((2181-1+$ID))
  MY_PEER_PORT=$((2888-1+$ID))
  MY_ELECTION_PORT=$((3888-1+$ID))

  echo "docker run -e \"ZK_SERVER_ID=$ID\""
  echo "-e \"ZK_CLIENT_SERVICE_PORT=2181\""

  for ((i=1; i<=$SIZE; i++)); do
    PEER_PORT=$((2888-1+$i))
    ELECTION_PORT=$((3888-1+$i))

    echo "-e \"ZK_PEER_${i}_SERVICE_HOST=$HOST\""
    echo "-e \"ZK_PEER_${i}_SERVICE_PORT=$PEER_PORT\""
    echo "-e \"ZK_ELECTION_${i}_SERVICE_HOST=$HOST\""
    echo "-e \"ZK_ELECTION_${i}_SERVICE_PORT=$ELECTION_PORT\""
  done

  echo "-p ${MY_CLIENT_PORT}:2181"
  echo "-p ${MY_PEER_PORT}:2888"
  echo "-p ${MY_ELECTION_PORT}:3888 fabric8/zookeeper &"
} 

[ "$#" -eq 2 ] || usage

SIZE=$1
HOST=$2
for ((i=1; i<=$SIZE; i++)); do
eval `server_run_str $i $SIZE $HOST`
done
