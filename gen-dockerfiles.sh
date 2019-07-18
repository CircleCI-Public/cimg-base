#!/usr/bin/env bash

version=( "$@" )
declare -a variants=("node")

repo="cimg/base:"

sed -r -e 's!%%BASE_VERSION%%!'"$version"'!g' "ubuntu/Dockerfile.template" > "ubuntu/Dockerfile"
