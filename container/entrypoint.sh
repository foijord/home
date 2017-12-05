#!/usr/bin/env bash

# run one x session in text mode (not graphical)
xinit -- :0 -nolisten tcp vt8 -noreset +extension GLX +extension RANDR +extension RENDER +extension XFIXES &

exec "$@"
