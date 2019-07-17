# vim:set ft=dockerfile:
#
# The Ubuntu-based CircleCI Docker Image. Only use Ubuntu Long-Term Support
# (LTS) releases.
FROM ubuntu:18.04

LABEL maintainer="CircleCI Community & Partner Engineering Team <community-partner@circleci.com>"

# Change default shell to Bash
SHELL ["/bin/bash", "-c"]

# Install utilities
RUN apt-get update \
  && apt-get install -y \
		build-essential \
		bzip2 \
		ca-certificates \
		curl \
		git \
		gnupg \
		gzip \
		jq \
		locales \
		make \
		mercurial \
		net-tools \
		netcat \
		openssh-client \
		parallel \
		tar \
		unzip \
		wget \
		xvfb \
		zip \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Install Docker
RUN set -ex \
	# Determine latest stable Docker version
  && declare -i INDEX=0 \
  && while :; \
  	do; \
  		INDEX_VERSION=$(curl --show-error --location --fail --retry 3 \
      https://api.github.com/repos/docker/cli/tags | \
      jq --argjson index "$INDEX" '.[$index].name') \
      # Filter out betas & release candidates
      if [[ $(echo "$INDEX_VERSION" | grep -v beta | grep -v rc) ]]; then; \
        DOCKER_VERSION="${INDEX_VERSION:1:$((${#INDEX_VERSION} - 1 - 1))}" \
        && break; \
      else; \
        INDEX=INDEX+1; \
      fi; \
    done \
  && DOCKER_VERSION_NUMBER="${DOCKER_VERSION:1}" \
  && DOCKER_BINARY_URL="https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION_NUMBER.tgz" \
  # Download Docker tarball
  && curl --output docker.tgz --show-error --location --fail --retry 3 \
    "$DOCKER_BINARY_URL" \
  && tar xf docker.tgz && rm -f docker.tgz \
  # Install Docker binaries
  && BINARIES=$(ls docker) && mv docker/* /usr/bin && rm -rf docker \
  && for binary in "$BINARIES"; \
    do; \
      chmod +x "/usr/bin/$binary"; \
    done \
  # Verify installation
  && which docker \
  && docker --version | grep "$DOCKER_VERSION_NUMBER"

# Missing Docker Compose, dockerize, and the CircleCI CLI
