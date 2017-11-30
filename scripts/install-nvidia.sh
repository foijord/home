#!/usr/bin/env bash

# install NVIDIA drivers
apt-add-repository -y ppa:graphics-drivers/ppa
apt-get update && apt-get install -y nvidia-387
