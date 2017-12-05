#!/bin/bash

docker image ls | awk '{ print $3 }' | xargs docker image rm -f
docker container ls --all | awk '{ print $1 }' | xargs docker rm
