#!/usr/bin/env bash

docker build --file 18.04/Dockerfile -t cimg/base:18.04 .
docker build --file 20.04/Dockerfile -t cimg/base:20.04 .
