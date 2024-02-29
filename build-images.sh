#!/usr/bin/env bash
# Do not edit by hand; please use build scripts/templates to make changes

docker context create cimg
docker buildx create --use cimg
docker buildx build --file 20.04/Dockerfile -t cimg/base:20.04 -t cimg/base:20.04 --platform=linux/amd64,linux/arm64 .
docker buildx build --file 22.04/Dockerfile -t cimg/base:22.04 -t cimg/base:22.04 --platform=linux/amd64,linux/arm64 .
