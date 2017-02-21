#!/bin/bash

###############################################################
#
# Script for bootstrapping a softlayer vm Ubuntu minimal install 
# with docker
#
# - installs the latest version of docker
# - installs the latest version of docker-compose
#
# Softlayer nodes have a root user enabled by default
#
###############################################################

echo `date` bootstrapping node...

echo `date` installing docker...

apt-get update && apt-get -y install linux-image-extra-$(uname -r) curl apt-transport-https
curl -L https://get.docker.com/ | sh

echo `date` installing docker-compose

apt-get install -y python

curl -L https://bootstrap.pypa.io/get-pip.py | python
pip install -U docker-compose

echo `date` finished
