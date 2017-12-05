#!/usr/bin/env bash

# stop on error
set -o errexit
set -o pipefail

gcloud beta compute \
       --project "vex-bed" instances create "$1" \
       --zone "europe-west1-d" \
       --machine-type "n1-standard-1" \
       --subnet "default" \
       --maintenance-policy "TERMINATE" \
       --service-account "vex-bed@appspot.gserviceaccount.com" \
       --scopes "https://www.googleapis.com/auth/cloud-platform" \
       --accelerator type=nvidia-tesla-k80,count=1 \
       --min-cpu-platform "Automatic" \
       --tags "http-server" \
       --image "ubuntu-1604-xenial-v20171121a" \
       --image-project "ubuntu-os-cloud" \
       --boot-disk-size "200" \
       --boot-disk-type "pd-standard" \
       --metadata-from-file startup-script=scripts/install-hostvm.sh \
       --boot-disk-device-name "$1"

# gcloud ssh command:
# gcloud compute --project "vex-bed" ssh --zone "europe-west1-d" "$1"
