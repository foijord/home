FROM ubuntu:16.04

# exit on error
RUN set -o errexit

# disable any user interaction during the build
ARG DEBIAN_FRONTEND=noninteractive
ARG REMOTEVIZ

RUN apt-get update && apt-get install -y \
    xorg \
    mesa-utils \
    libglu1-mesa \
    libossp-uuid16 \
    xserver-xorg-dev \
    software-properties-common

# install NVIDIA driver
RUN apt-add-repository -y ppa:graphics-drivers/ppa
RUN apt-get update && apt-get install -y nvidia-387
RUN nvidia-xconfig -a --use-display-device=None --virtual=4096x2160

# ADD unpacks the archive automatically
ADD $REMOTEVIZ /

# change working directory to directory containing executables
WORKDIR /SlbRemoteViz/bin

# run one x session in text mode (not graphical)
RUN echo 'manual' | dd of=/etc/init/lightdm.override
RUN systemctl set-default multi-user.target

# add working directory to library path
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.
ENV DISPLAY=:0

EXPOSE 8080
# stuff that must be executed after the container is started,
# i.e. configure and start the X server
COPY entrypoint.sh /scripts/
ENTRYPOINT ["/scripts/entrypoint.sh"]
