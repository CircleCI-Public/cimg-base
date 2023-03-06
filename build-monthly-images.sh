#!/usr/bin/env bash
# Do not edit by hand; please use build scripts/templates to make changes

docker context create cimg
docker buildx create --use cimg

VERSION=$( date +%Y.%m )

echo "The 'version' is ${VERSION}"

docker buildx build --platform=linux/amd64,linux/arm64 --file 20.04/Dockerfile -t cimg/base:${VERSION}-20.04 -t cimg/base:current-20.04 .
docker buildx build --platform=linux/amd64,linux/arm64 --file 22.04/Dockerfile -t cimg/base:${VERSION}-22.04 -t cimg/base:${VERSION} -t cimg/base:current-22.04 -t cimg/base:current .
