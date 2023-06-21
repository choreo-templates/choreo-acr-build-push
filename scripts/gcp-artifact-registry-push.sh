#!/bin/bash

key_path=$1
project_id=$2
region=$3
registry=$4
repository=$5
image_tag=$6


# # Authenticate gcloud with service account
# gcloud auth activate-service-account --key-file=$key_path --project=$project_id

# # Checking whether the repository is already exisits or not
# gcloud artifacts repositories describe $repository --project=$project_id --location=$region

# # Create repositpory if the doesn't exisits
# if [ $? != 0 ]; then
#     gcloud artifacts repositories create $repository --location=$region --repository-format=docker --mode=standard-repository 
# else
#     echo "The repository already exists"
# fi

# Docker login by service account key
cat $key_path | docker login -u _json_key --password-stdin $registry
docker image tag $DOCKER_TEMP_IMAGE  $image_tag
docker push $image_tag

# Revoke gcloud
# gcloud auth revoke --all
docker logout $registry
rm -rf gcp-key.json