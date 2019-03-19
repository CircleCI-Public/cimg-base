# vim:set ft=dockerfile:
#
# The Ubuntu-based CircleCI Docker Image. Only use Ubuntu Long-Term Support 
# (LTS) releases.
FROM ubuntu:18.04

LABEL maintainer="CircleCI <support@circleci.com>"

# Change default shell from Dash to Bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y \
	bzip2 \
	ca-certificates \
	curl \
	# Do we actually want this?
	xvfb \
	git \
	gnupg \
	gzip \
	jq \
	# Need to figure out what this is
	locales \
	# Do we actually want this?
	mercurial \
	net-tools \
	netcat \
	openssh-client \
	# Need to figure out what this is
	parallel \
	# Only if we aren't using the root user (Docker Ubuntu/Alpine default)
	sudo \
	tar \
	unzip \
	wget \
	zip
# Missing Docker, Docker Compose, dockerize, and the CircleCI CLI

# This matches the default CircleCI working directory.
WORKDIR /root/project
