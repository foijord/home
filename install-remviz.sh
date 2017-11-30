#!/usr/bin/env bash

# stop on error
set -o errexit
set -o pipefail

# pull docker image from google container registry
sudo gcloud docker -- pull us.gcr.io/vex-bed/remoteviz

# run docker RemoteScene example from SlbRemoteViz
sudo docker run us.gcr.io/vex-bed/remoteviz ./RemoteScene

