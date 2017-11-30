#!/usr/bin/env bash

apt-get install -y \
	xorg \
	mesa-utils \
	libglu1-mesa \
	xserver-xorg-dev

echo 'manual' | sudo dd of=/etc/init/lightdm.override
systemctl set-default multi-user.target
nvidia-xconfig -a --use-display-device=None --virtual=4096x2160
