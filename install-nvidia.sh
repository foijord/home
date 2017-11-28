#!/usr/bin/env bash

# install NVIDIA drivers
sudo apt-add-repository -y ppa:graphics-drivers/ppa
sudo apt-get update && sudo apt-get install -y nvidia-375

# run in text mode (not graphical)
sudo apt-get install -y xorg
echo 'manual' | dd of=/etc/init/lightdm.override
systemctl set-default multi-user.target
nvidia-xconfig -a --use-display-device=None --virtual=4096x2160

export DISPLAY=:0
