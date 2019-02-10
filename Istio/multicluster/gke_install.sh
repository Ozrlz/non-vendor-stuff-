#!/bin/bash

echo "
This will create two clusters on 'us-central1-a'.
One will contain the control-plane (istiomc-cp) and the other will do as remote (istiomc-rm).
You account will be binded to a high-privileged account in the cluster's RBAC, so don't use in prod. Or do it I don't care TBH.
Also this need Helm in order to run because the Istio guys use it and generating the YAMLs without it is a PITA so, yeah this will add that binary.

The only thing this script needs for now is your GCP email to create the RBAC binding. Don't fuck it up because I haven't implemented a retry logic yet.
"
read -p "Vamoaselo? [ y | n ]: " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Aborting..."
    exit 1
fi

echo "Ok!"

# Vars
zone="us-central1-a"


# Cluster creation
# Control-plane
gcloud container clusters create istiomc-cp --zone $zone --username "admin" \
  --cluster-version "1.9.6-gke.1" --machine-type "n1-standard-2" --image-type "COS" --disk-size "100" \
  --scopes "https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_only",\
  "https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring",\
  "https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly",\
  "https://www.googleapis.com/auth/trace.append" \
  --num-nodes "4" --network "default" --enable-cloud-logging --enable-cloud-monitoring --enable-ip-alias --async

  # Remote
gcloud container clusters create istiomc-rm --zone $zone --username "admin" \
  --cluster-version "1.9.6-gke.1" --machine-type "n1-standard-2" --image-type "COS" --disk-size "100" \
  --scopes "https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_only",\
  "https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring",\
  "https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly",\
  "https://www.googleapis.com/auth/trace.append" \
  --num-nodes "4" --network "default" --enable-cloud-logging --enable-cloud-monitoring --enable-ip-alias --async