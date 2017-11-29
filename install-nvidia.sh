#!/usr/bin/env bash

# stop on error
set -e

# install NVIDIA drivers
sudo apt-add-repository -y ppa:graphics-drivers/ppa
sudo apt-get update && sudo apt-get install -y nvidia-375

# install CUDA
# curl -LO http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
# sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
# sudo apt-get update && sudo apt-get install cuda

sudo apt-get install -y \
     xorg \
     mesa-utils \
     xserver-xorg-dev

# run in text mode (not graphical)
echo 'manual' | sudo dd of=/etc/init/lightdm.override
sudo systemctl set-default multi-user.target
sudo nvidia-xconfig -a --use-display-device=None --virtual=4096x2160

# run only one X session:
sudo xinit -- :0 -nolisten tcp vt8 -noreset +extension GLX +extension RANDR +extension RENDER +extension XFIXES &

# export DISPLAY=:0
# glxinfo | grep -i opengl
