#!/usr/bin/env bash
# The edge default must be updated manually

docker context create cimg
docker buildx create --use cimg
docker buildx build --push --platform=linux/amd64,linux/arm64 --file 22.04/Dockerfile -t cimg/base:edge-22.04 .
docker buildx build --push --platform=linux/amd64,linux/arm64 --file 24.04/Dockerfile -t cimg/base:edge-24.04 -t cimg/base:edge .
