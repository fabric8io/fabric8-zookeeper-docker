#!/bin/bash

osc delete service zookeeper-1
osc delete service zookeeper-2
osc delete service zookeeper-3

osc delete pod zookeeper-1
osc delete pod zookeeper-2
osc delete pod zookeeper-3
