## In your home folder, initialize a git repo:
`git init .`

## Add this repository as a remote:
`git remote add origin https://github.com/foijord/home.git`

## Fetch dotfiles and scripts:
`git pull origin master`

## get SlbRemoteViz:
`gsutil cp gs://slb-cloud-3d-viz/SlbRemoteViz/Linux/pkg_4/SlbRemoteViz.linux_package_4.build_73998.tar.gz .`

## if you're on windows subsystem for linux: expose the Windows docker daemon 
## from docker settings/general, then specify DOCKER_HOST:
`export DOCKER_HOST=tcp://localhost:2375`

## build container
`sudo -E docker build -t remviz .`

## run RemoteScene example app locally
`docker run remviz ./RemoteScene`

## open interactive shell in container
`docker run -it remviz /bin/bash`

## tag docker image
`sudo -E docker tag remviz us.gcr.io/vex-bed/remviz`

## push docker image to google container registry (gcr)
`sudo -E gcloud docker -- push us.gcr.io/vex-bed/remviz`

## pull docker image from google container registry
`sudo gcloud docker -- pull us.gcr.io/vex-bed/remviz`

## run docker container on VM
`sudo docker run --privileged -it us.gcr.io/vex-bed/remviz /bin/bash`
