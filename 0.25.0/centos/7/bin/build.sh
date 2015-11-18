#!/bin/bash
#
#

DOCKER=docker

if [ ! -e Dockerfile ]
then
   echo "Dockerfile not found in $(pwd)"
   exit 1
fi
if [ $0 != bin/build.sh ]
then
   echo "To build this image, you HAVE to use the bin/build.sh script. You started '$0' which is not supported."
   exit 1
fi

if [ "$DOCKER_SUDO" = true ]
then
   DOCKER="sudo docker"
fi

if [ ! -e .docker.build ]
then
   echo ".docker.build definition file is missing. Please create one, with TAG set"
   exit 1
fi

source .docker.build

if [ "$TAG" = "" ]
then
   echo ".docker.build definition file exist but without TAG set. Please add it."
   exit 1
fi

$DOCKER build -t $TAG .


if [ $? -ne 0 ]
then
   echo "Docker image build process has failed. Please review."
   exit 1
fi

echo "Press Enter to pushing the image '$TAG' to the repository."
read

$DOCKER push $TAG

echo "Done"
