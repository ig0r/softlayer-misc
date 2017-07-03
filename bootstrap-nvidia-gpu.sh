#!/bin/bash

###############################################################
#
# Script for bootstrapping a softlayer bare metal server 
# 
#
# - installs the latest version of docker ce
# - installs the nvidia-docker
# - installs nvidia drivers
#
# Softlayer nodes have a root user enabled by default
#
###############################################################

echo `date` bootstrapping node...

echo `date` installing docker...

apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update

apt-get install -y docker-ce

echo `date` installing nvidia-docker...

wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb

echo `date` installing nvidia drivers...
wget -P http://us.download.nvidia.com/tesla/375.66/nvidia-diag-driver-local-repo-ubuntu1604_375.66-1_amd64.deb
dpkg -i nvidia-diag-driver-local-repo-ubuntu1604_375.66-1_amd64.deb
rm nvidia-diag-driver-local-repo-ubuntu1604_375.66-1_amd64.deb

apt-get update
apt-get install -y cuda-drivers

echo `date` checking nvidia

nvidia-docker run --rm nvidia/cuda nvidia-smi

shutdown -r now

echo `date` finished
