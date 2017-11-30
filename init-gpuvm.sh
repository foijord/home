#!/usr/bin/env bash

# stop on error
set -o errexit
set -o pipefail

sudo sh ./install-common.sh
sudo sh ./install-nvidia.sh
sudo sh ./install-xstuff.sh
sudo sh ./restart-xstuff.sh
