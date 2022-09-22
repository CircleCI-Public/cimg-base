#!/usr/bin/env bash
# Do not edit by hand; please use build scripts/templates to make changes

docker context create cimg
docker buildx create --use cimg
docker buildx build --push --platform=linux/amd64,linux/arm64 --file 22.04/Dockerfile -t cimg/base:edge-22.04 -t cimg/base:edge .
