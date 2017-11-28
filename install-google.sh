#!/usr/bin/env bash

sh install-common.sh

# Install Google Cloud SDK:
# Create an environment variable for the correct distribution:
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

# Add the Cloud SDK distribution URI as a package source:
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud public key:
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Update and install the Cloud SDK:
sudo apt-get update
sudo apt-get install -y google-cloud-sdk

# Run gcloud init to get started:
gcloud init

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"

sudo apt-get update
sudo apt-get install -y docker-ce
