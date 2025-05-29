#!/usr/bin/env bash
# The current default must be updated manually
docker context create cimg
docker buildx create --use cimg

VERSION=$( date +%Y.%m )

echo "The 'version' is ${VERSION}"

docker buildx build --platform=linux/amd64,linux/arm64 --file 22.04/Dockerfile -t cimg/base:${VERSION}-22.04 -t cimg/base:current-22.04 .
docker buildx build --platform=linux/amd64,linux/arm64 --file 24.04/Dockerfile -t cimg/base:${VERSION}-24.04 -t cimg/base:${VERSION} -t cimg/base:current-24.04 -t cimg/base:current .
