#!/usr/bin/env bash

# Install packages to allow apt to use a repository over HTTPS:
apt-get update && apt-get install -y \
			  apt-transport-https \
			  ca-certificates \
			  curl \
			  software-properties-common

