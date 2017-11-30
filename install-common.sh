#!/usr/bin/env bash

# stop on error
set -o errexit
set -o pipefail

# Install packages to allow apt to use a repository over HTTPS:
sudo apt-get update && sudo apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     software-properties-common

