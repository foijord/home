#!/usr/bin/env bash

# run in text mode (not graphical)
echo 'manual' | sudo dd of=/etc/init/lightdm.override
sudo systemctl set-default multi-user.target
sudo nvidia-xconfig -a --use-display-device=None --virtual=4096x2160

# run only one X session:
sudo xinit -- :0 -nolisten tcp vt8 -noreset +extension GLX +extension RANDR +extension RENDER +extension XFIXES &

export DISPLAY=:0
