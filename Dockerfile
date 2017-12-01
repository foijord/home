FROM ubuntu:16.04

# exit on error
RUN set -o errexit

# disable any user interaction during the build
ARG DEBIAN_FRONTEND=noninteractive

COPY scripts /scripts

WORKDIR /scripts/

RUN chmod +x *.sh

RUN sh ./install-common.sh \
       ./install-xstuff.sh \
       ./install-nvidia.sh

# libossp-uuid16 needed by SlbRemoteViz
RUN apt-get install -y libossp-uuid16

# ADD unpacks the archive automatically
ADD SlbRemoteViz.linux_package_4.build_73998.tar.gz /

# change working directory to directory containing executables
WORKDIR /SlbRemoteViz/bin

EXPOSE 8080

ENTRYPOINT ["/scripts/execute-remviz.sh"]
