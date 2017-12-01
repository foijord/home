#!/usr/bin/env bash

# run one x session in text mode (not graphical)
nvidia-xconfig -a --use-display-device=None --virtual=4096x2160
xinit -- :0 -nolisten tcp vt8 -noreset +extension GLX +extension RANDR +extension RENDER +extension XFIXES &

exec "$@"
