#!/usr/bin/env bash
# The edge default must be edited manually

docker context create cimg
docker buildx create --use cimg
docker buildx build --platform=linux/amd64,linux/arm64 --file 22.04/Dockerfile -t cimg/base:edge-22.04 -t cimg/base:edge .
docker buildx build --platform=linux/amd64,linux/arm64 --file 24.04/Dockerfile -t cimg/base:edge-24.04 .
