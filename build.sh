#!/usr/bin/env bash

REGISTRY=registry.hub.docker.com/leadersleague

function build() {
        docker build -t "${REGISTRY}/${1}" -f ./Dockerfile .
        docker tag  "${REGISTRY}/${1}" "${REGISTRY}/${1}"
        docker push "${REGISTRY}/${1}"
}

function build_and_push_images() {
    build pipeline
}

#is ssh agent set ?
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add
fi

build_and_push_images
exit 0
