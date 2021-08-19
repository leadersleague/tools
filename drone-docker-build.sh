#!/usr/bin/env bash

export DOCKER_REGISTRY=registry-1.docker.io
export DOCKER_FULL_REPO=$DOCKER_REGISTRY/leadersleague/${DRONE_REPO_NAME}
export DOCKER_TAG=${DRONE_BRANCH}-${DRONE_COMMIT_SHA}
mkdir $HOME/.docker
echo "{\"auths\":{\"$DOCKER_REGISTRY\":{\"auth\":\"$(echo -n $DOCKER_USERNAME:$DOCKER_PASSWORD | base64)\"}}}" > $HOME/.docker/config.json
docker build -t $DOCKER_FULL_REPO -f docker/Dockerfile .
docker tag $DOCKER_FULL_REPO $DOCKER_FULL_REPO:$DOCKER_TAG
docker push $DOCKER_FULL_REPO
docker push $DOCKER_FULL_REPO:$DOCKER_TAG
docker rmi $DOCKER_FULL_REPO $DOCKER_FULL_REPO:$DOCKER_TAG
