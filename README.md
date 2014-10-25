Fabric8 - ZooKeeper Docker Image
================================

This is a docker image that can be used to run ZooKeeper on Docker. The image uses the official ZooKeeper distribution.
The image is meant to be used for starting "quorum servers". To make use of this feature special env variables need to be passed.

Getting Started
---------------

The easiest way to make use of this image is to use the "setup-ensemble.sh" script which is part of this repo. The script provides an easy way to start ZooKeeper Ensembles of variable size, without having to go through the pain of manually setting up env variables. For example

- To create a 3 server ensemble:
	./setup-ensmble.sh 3 <<docker ip>>

- To create a 5 server ensemble:
	./setup-ensemble 5 <<docker ip>>
		
and so on.

Environment Variables
---------------------
Below is a list of the supported environment variables:
	- ZK_SERVER_ID						The id of the server (refers to myid)
	- ZK_CLIENT_SERVICE_PORT			The ZooKeeper clientPort
	- ZK_PEER_<<id>>_SERVICE_HOST		The Peer Hostname for the server with id equal to <<id>>
	- ZK_PEER_<<id>>_SERVICE_PORT		The Peer Port for the server with id equal to <<id>>
	- ZK_ELECTION_<<id>>_SERVICE_HOST	The Election Port for the server with id equal to <<id>>
	
The environment variable names are carefully selected so that they can be kubernetes friendly.

Enjoy!