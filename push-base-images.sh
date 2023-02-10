#!/usr/bin/env bash
# Do not edit by hand; please use build scripts/templates to make changes

docker context create cimg
docker buildx create --use cimg
docker buildx build --push --platform=linux/amd64,linux/arm64 --file 18.04/Dockerfile -t cimg/base:edge-18.04
docker buildx build --push --platform=linux/amd64,linux/arm64 --file 20.04/Dockerfile -t cimg/base:edge-20.04
docker buildx build --push --platform=linux/amd64,linux/arm64 --file 22.04/Dockerfile -t cimg/base:edge-22.04 -t cimg/base:edge .
