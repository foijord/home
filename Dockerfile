FROM ubuntu:16.04

# exit on error
RUN set -o errexit

# disable any user interaction during the build
ARG DEBIAN_FRONTEND=noninteractive

# apt-add-repository dependency (used by install-nvidia.sh)
RUN apt-get update && apt-get install -y software-properties-common

COPY scripts/install-xstuff.sh /scripts/
COPY scripts/install-nvidia.sh /scripts/
COPY scripts/execute-remviz.sh /scripts/

WORKDIR /scripts/

RUN ./install-nvidia.sh
RUN ./install-xstuff.sh

# libossp-uuid16 needed by SlbRemoteViz
RUN apt-get install -y libossp-uuid16

# ADD unpacks the archive automatically
ADD SlbRemoteViz.linux_package_4.build_73998.tar.gz /

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
ENTRYPOINT ["/scripts/execute-remviz.sh"]
