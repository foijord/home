#!/usr/bin/env bash

# stop on error
set -o errexit
set -o pipefail

# Installing Docker CE on ubuntu 16:04 VM
# https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository

# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Use the following command to set up the stable repository. You always
# need the stable repository, even if you want to install builds from
# the edge or test repositories as well. To add the edge or test
# repository, add the word edge or test (or both) after the word stable
# in the commands below.

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install the latest version of Docker CE. Any existing installation
# of Docker is replaced.
sudo apt-get update && sudo apt-get install -y docker-ce
