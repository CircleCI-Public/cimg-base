#!/usr/bin/env bash

version=( "$@" )
declare -a variants=("node")

repo="circleciimages/base:"

sed -r -e 's!%%BASE_VERSION%%!'"$version"'!g' "ubuntu/Dockerfile.template" > "ubuntu/Dockerfile"

# prepare file
echo "#!/usr/bin/env bash" > build-images.sh
echo "" >> build-images.sh

echo "docker build --file=ubuntu/Dockerfile -t ${repo}latest ." >> build-images.sh


for i in "${variants[@]}"; do
	echo "docker build --file=variant-${i}/Dockerfile -t ${repo}${i} ." >> build-images.sh
done
