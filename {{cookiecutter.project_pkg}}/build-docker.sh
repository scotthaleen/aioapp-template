#!/usr/bin/env sh


DT=$(date +"%Y%m%d")
GIT=${DT}.git.$(git rev-parse --short HEAD)
VERSION="{{cookiecutter.version}}"

GROUP={{cookiecutter.dockerhub_user}}
NAME={{cookiecutter.project_pkg}}
IMAGE="${GROUP}/${NAME}"

docker build \
       -t "${IMAGE}:dev" \
       -t "${IMAGE}:${VERSION}" \
       -t "${IMAGE}:${GIT}" \
       -t "${NAME}:${VERSION}" \
       .
