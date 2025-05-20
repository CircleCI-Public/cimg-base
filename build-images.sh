#!/usr/bin/env bash
# Do not edit by hand; please use build scripts/templates to make changes
set -eo pipefail

docker context create cimg
docker buildx create --use cimg
docker buildx build --platform=linux/amd64,linux/arm64 --file 22.04/Dockerfile -t cimg/base:22.04 -t cimg/base:22.04 --push .
docker buildx build --platform=linux/amd64,linux/arm64 --file 24.04/Dockerfile -t cimg/base:24.04 -t cimg/base:24.04 --push .
