#!/usr/bin/env bash

# install NVIDIA drivers
sudo apt-add-repository -y ppa:graphics-drivers/ppa
sudo apt-get update && apt-get install -y nvidia-375

