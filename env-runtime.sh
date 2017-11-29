#!/bin/bash

# stop on error
set -e

echo "==================================================="
echo "     Welcome to slb-remote-viz-server setup :-)    "
echo "           Pre-requisite: Ubuntu 16.04             "
echo "==================================================="
echo ""

sudo apt -y update
sudo apt -y upgrade
sudo apt -f install

sudo apt-get install -y software-properties-common

echo ""
echo "---------------------------------------------------"
echo "*** Install X stuff                                "
echo "---------------------------------------------------"
sudo DEBIAN_FRONTEND=noninteractive apt install -y x11-xserver-utils \
  xorg \
  openbox \
  xauth \
  x11vnc \
  xinit \
  xserver-xorg-video-dummy \
  xserver-xorg-input-void \
  texlive-fonts-recommended

# linux-image-extra-virtual prevents NVIDIA driver modprobe failure
sudo apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  module-init-tools \
  linux-image-extra-virtual \
  && apt -y clean all
sudo apt-get -y install git

echo ""
echo "---------------------------------------------------"
echo "*** Install CUDA stuff                             "
echo "---------------------------------------------------"
sudo apt install -y curl
curl -LO https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run
sudo sh cuda_8.0.61_375.26_linux-run --silent --driver --toolkit --verbose
rm -f cuda_8.0.61_375.26_linux-run

echo ""
echo "---------------------------------------------------"
echo "*** Install MESA stuff                             "
echo "---------------------------------------------------"
sudo apt install -y mesa-utils \
  libgl1-mesa-dri \
  libglu1-mesa \
  libgl1-mesa-glx \
  libglapi-mesa \
  libosmesa6 \
   && apt -y clean all

echo ""
echo "---------------------------------------------------"
echo "*** Install NVidia drivers                         "
echo "---------------------------------------------------"
sudo apt-add-repository -y ppa:graphics-drivers/ppa
sudo apt-get -y update
sudo apt-get install -y nvidia-381

sudo apt install -y libxm4 libuil4 libmrm4 libmotif-common

echo ""
echo "---------------------------------------------------"
echo "*** Install CMake & Python & build-essential       "
echo "*** Install CMake & Python & build-essential       "
echo "---------------------------------------------------"
sudo apt-get -y install build-essential
sudo apt-get -y install cmake
sudo apt-get -y install libpython2.7-dev
sudo apt-get -y install python-pip
sudo apt-get -y install libmotif-common libmotif-dev


echo "============================================================"
echo "     About to install the pre-reqs for the auto tests :)    "
echo "============================================================"
echo ""

echo ""
echo "---------------------------------------------------"
echo "                 Check Installations               "
echo "---------------------------------------------------"
sudo pip install Pillow

echo ""
echo "---------------------------------------------------"
echo "                Install ImageMagick                "
echo "---------------------------------------------------"

sudo apt-get -y install imagemagick


echo ""
echo "---------------------------------------------------"
echo "*** Install 4.9 compilers                          "
echo "---------------------------------------------------"
# disable stop on error as this lists quite a few errors when 
# packages aren't found
set +e
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo apt-get install -y gcc-4.9 g++-4.9 c++-4.9
sudo update-alternatives --remove-all gcc
sudo update-alternatives --remove-all g++
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 10
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 20
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 10
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 20
# uninstall unneeded cross compiler parts and doc
cross_packages=$(apt list | grep installed | grep 4.9 | grep cross | grep -v arm64 | grep -v aarch64 | awk '{print $1}' | cut -d "/" -f1)
for p in $cross_packages; do apt remove --auto-remove -y $p; done 
doc_packages=$(apt list | grep doc | grep installed | cut -d "/" -f1) 
for p in $doc_packages; do apt remove --auto-remove -y $p; done 
# reenable stop on error
set -e


echo ""
echo "---------------------------------------------------"
echo "*** Install golang compilers (boringssl req)       "
echo "---------------------------------------------------"
sudo apt-get -y install golang

echo FOR SOME READON THIS GOES MISSING
sudo apt-get -y install libmotif-dev

echo ""
echo "---------------------------------------------------"
echo "*** Install Google Cloud SDK                       "
echo "---------------------------------------------------"
sudo apt-get -y install lsb-core
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get -y update
sudo apt-get -y install google-cloud-sdk

echo ""
echo "---------------------------------------------------"
echo "*** Install bucket support                         "
echo "---------------------------------------------------"
export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s`
echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get -y update
sudo apt-get -y install gcsfuse
sudo bash -c 'cat << EOF > /etc/fuse.conf
# Allow non-root users to specify the 'allow_other' or 'allow_root'
# mount options.
user_allow_other
EOF'

echo ""
echo "---------------------------------------------------"
echo "*** Install ZGY Salmon Dependencies                "
echo "---------------------------------------------------"
sudo apt-get -y install libossp-uuid16 \
   && apt -y clean all

echo ""
echo "---------------------------------------------------"
echo "*** Install Stackdriver for logging                "
echo "---------------------------------------------------"
curl -O https://repo.stackdriver.com/stack-install.sh
sudo bash stack-install.sh --write-gcm
curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh
sudo bash install-logging-agent.sh

echo ""
echo "---------------------------------------------------"
echo "*** Manually start X                               "
echo "---------------------------------------------------"
# run in text mode (not graphical)
echo 'manual' | sudo dd of=/etc/init/lightdm.override  
sudo systemctl set-default multi-user.target 

sudo nvidia-xconfig -a --use-display-device=None --virtual=4096x2160 

#Run only one X session:
sudo xinit -- :0 -nolisten tcp vt8 -noreset +extension GLX +extension RANDR +extension RENDER +extension XFIXES &

echo ""
echo "-----------------------------------------------------------------"
echo "*** If this script has succeeded, you can build the code base :-)"
echo "    To test, type these two commands:                            "
echo "        export DISPLAY=:0                                        "
echo "        glxinfo | grep -i opengl                                 "
echo "-----------------------------------------------------------------"
