#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y emacs24


# install docker
sudo apt-get install -y \
     emacs24 \
     apt-transport-https \
     ca-certificates \
     curl \
     software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
sudo apt-get update

sudo apt-get install -y docker-ce
