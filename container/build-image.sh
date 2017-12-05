#!/usr/bin/env bash

echo "---------------------------------------------------"
echo "*** fetch SlbRemoteViz from bucket                 "
echo "---------------------------------------------------"
#REMOTEVIZ_VERSION=gs://slb-cloud-3d-viz/SlbRemoteViz/Linux/pkg_5/SlbRemoteViz.linux_package_5.build_79788.tar.gz

REMOTEVIZ_PATH=gs://slb-cloud-3d-viz/SlbRemoteViz/Linux/pkg_4
REMOTEVIZ_BUILD=SlbRemoteViz.linux_package_4.build_73998.tar.gz

gsutil cp $REMOTEVIZ_PATH/$REMOTEVIZ_BUILD .

echo "---------------------------------------------------"
echo "*** build Docker container                         "
echo "---------------------------------------------------"
# if you're on windows subsystem for linux: expose the Windows docker daemon 
# from docker settings/general, then specify DOCKER_HOST:
export DOCKER_HOST=tcp://localhost:2375

# build container
docker build --build-arg REMOTEVIZ=$REMOTEVIZ_BUILD --tag remviz .

# tag docker image
docker tag remviz us.gcr.io/vex-bed/remviz

echo "---------------------------------------------------"
echo "*** push Docker container to us.gcr.io             "
echo "---------------------------------------------------"
# push docker image to google container registry (gcr)
gcloud docker -- push us.gcr.io/vex-bed/remviz
