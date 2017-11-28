#!/usr/bin/env bash

# Install packages to allow apt to use a repository over HTTPS:
sudo apt-get update && sudo apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     software-properties-common

