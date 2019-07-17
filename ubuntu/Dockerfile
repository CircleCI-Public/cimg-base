# vim:set ft=dockerfile:
#
# The Ubuntu-based CircleCI Docker Image. Only use Ubuntu Long-Term Support
# (LTS) releases.
FROM ubuntu:18.04

LABEL maintainer="CircleCI Community & Partner Engineering Team <community-partner@circleci.com>"

# Change default shell to Bash
SHELL ["/bin/bash"]

RUN apt-get update && apt-get install -y \
	bzip2 \
	ca-certificates \
	curl \
	xvfb \
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
	zip && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
# Missing Docker, Docker Compose, dockerize, and the CircleCI CLI
