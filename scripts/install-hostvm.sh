#!/usr/bin/env bash

# stop on error
set -o errexit
set -o pipefail

echo "---------------------------------------------------"
echo "*** install gcloud                                 "
echo "---------------------------------------------------"
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

# Add the Cloud SDK distribution URI as a package source:
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud public key:
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# Update and install the Cloud SDK:
apt-get update && apt-get install -y google-cloud-sdk

echo "---------------------------------------------------"
echo "*** install docker                                 "
echo "---------------------------------------------------"
# Installing Docker CE on ubuntu 16:04 VM
# https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository

# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Use the following command to set up the stable repository. You always
# need the stable repository, even if you want to install builds from
# the edge or test repositories as well. To add the edge or test
# repository, add the word edge or test (or both) after the word stable
# in the commands below.
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install the latest version of Docker CE. Any existing installation
# of Docker is replaced.
apt-get update && apt-get install -y docker-ce

echo "---------------------------------------------------"
echo "*** install nvidia driver                          "
echo "---------------------------------------------------"

# install NVIDIA drivers
apt-add-repository -y ppa:graphics-drivers/ppa
apt-get update && apt-get install -y nvidia-387
# nvidia-xconfig -a --use-display-device=None --virtual=4096x2160

echo "---------------------------------------------------"
echo "*** pull remviz image from gcr                     "
echo "---------------------------------------------------"
sudo gcloud docker -- pull us.gcr.io/vex-bed/remviz

echo "---------------------------------------------------"
echo "*** start docker container                         "
echo "---------------------------------------------------"
sudo docker run --privileged -it us.gcr.io/vex-bed/remviz /bin/bash
