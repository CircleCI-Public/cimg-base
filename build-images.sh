#!/usr/bin/env bash

docker build --file=ubuntu/Dockerfile -t circleciimages/base:latest .
docker build --file=variant-node/Dockerfile -t circleciimages/base:node .
