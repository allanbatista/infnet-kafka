#!/bin/bash

apt-get update  && \
apt-get upgrade -y && \
apt-get remove docker docker-engine docker.io containerd runc && \
apt-get install apt-transport-https \
                ca-certificates \
                curl \
                gnupg-agent \
                software-properties-common -y && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
apt-key fingerprint 0EBFCD88 && \
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
apt-get update && \
apt-get install docker-ce docker-ce-cli containerd.io -y