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
# this produces a warning about package xorg-server not found since X
# is not installed on the VM. But the docker container still runs.
./install-nvidia.sh

echo "---------------------------------------------------"
echo "*** pull remviz image from gcr                     "
echo "---------------------------------------------------"
gcloud docker -- pull us.gcr.io/vex-bed/remviz

echo "---------------------------------------------------"
echo "*** start docker container                         "
echo "---------------------------------------------------"
docker run --privileged -it us.gcr.io/vex-bed/remviz /bin/bash
