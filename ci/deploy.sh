#!/bin/sh
set -ev
echo -n "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push umweltdk/k8s-deploy:latest
docker push umweltdk/k8s-deploy:nixos-stable
docker push umweltdk/k8s-deploy:nixos-unstable
