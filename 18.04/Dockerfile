# vim:set ft=dockerfile:

FROM ubuntu:18.04

LABEL maintainer="Community & Partner Engineering Team <community-partner@circleci.com>"

# Change default shell for RUN from Dash to Bash
SHELL ["/bin/bash", "-exo", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

# Configure environment
RUN echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90circleci && \
	echo 'DPkg::Options "--force-confnew";' >> /etc/apt/apt.conf.d/90circleci && \
	apt-get update && apt-get install -y \
		curl \
		locales \
		sudo \
	&& \
	locale-gen en_US.UTF-8 && \
	rm -rf /var/lib/apt/lists/* && \

	useradd --uid=3434 --user-group --create-home circleci && \
	echo 'circleci ALL=NOPASSWD: ALL' >> /etc/sudoers.d/50-circleci && \
	echo 'Defaults    env_keep += "DEBIAN_FRONTEND"' >> /etc/sudoers.d/env_keep && \
	sudo -u circleci mkdir /home/circleci/project && \

	# Install Dockerize v0.6.1
	# Source repo: https://github.com/jwilder/dockerize
	# I (Ricardo) would like to replace this one day. It's a tool not really
	# maintained and we can likely offer something better.
	curl -sSL --fail --retry 3 --output /tmp/dockerize-linux-amd64.tar.gz "https://circle-downloads.s3.amazonaws.com/circleci-images/cache/linux-amd64/dockerize-latest.tar.gz" && \
	tar -C /usr/local/bin -xzvf /tmp/dockerize-linux-amd64.tar.gz && \
	rm -rf /tmp/dockerize-linux-amd64.tar.gz && \
	# Quick test of Dockerize
	dockerize --version

ENV PATH=/home/circleci/bin:/home/circleci/.local/bin:$PATH \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US:en \
	LC_ALL=en_US.UTF-8

RUN apt-get update && apt-get install -y \
		autoconf \
		build-essential \
		ca-certificates \
		# already installed but hear for consistency
		curl \
		git \
		gnupg \
		gzip \
		jq \
		# popular DB lib - MariaDB
		libmariadb-dev \
		# allows MySQL users to use MariaDB lib
		libmariadb-dev-compat \
		# popular DB lib - PostgreSQL
		libpq-dev \
		make \
		# for ssh-enabled builds
		nano \
		net-tools \
		netcat \
		openssh-client \
		parallel \
		# compiling tool
		pkg-config \
		software-properties-common \
		# already installed but hear for consistency
		sudo \
		tar \
		tzdata \
		unzip \
		# for ssh-enabled builds
		vim \
		wget \
		zip && \
	rm -rf /var/lib/apt/lists/*

# Install Docker - needs the setup_remote_docker CircleCI step to work
ENV DOCKER_VERSION 5:19.03.14~3-0~ubuntu-
RUN apt-get update && apt-get install -y \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg-agent \
		software-properties-common && \
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
	add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
	apt-get install -y docker-ce=${DOCKER_VERSION}$(lsb_release -cs) docker-ce-cli=${DOCKER_VERSION}$(lsb_release -cs) containerd.io && \
	# Quick test of the Docker install
	docker --version && \
	rm -rf /var/lib/apt/lists/*

# Install Docker Compose - see prerequisite above
ENV COMPOSE_VERSION 1.28.0
RUN curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
	chmod +x /usr/local/bin/docker-compose && \
	# Quick test of the Docker Compose install
	docker-compose version

USER circleci

# Match the default CircleCI working directory
WORKDIR /home/circleci/project
