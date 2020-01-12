# vim:set ft=dockerfile:

# The core18 image is based off of CircleCI's cimg/base image. That image is 
# based on Ubuntu 18.04. There is no 16.04-based upstream image so we 
# replicate the cimg/base layers here instead. This shouldn't be an issue when 
# Ubuntu 20.04 / core20 comes out.

# Ubuntu 16.04 image to match the core16 snap
FROM ubuntu:16.04

LABEL maintainer="Ricardo N Feliciano (FelicianoTech) <Ricardo@Feliciano.Tech>"

# Change default shell from Dash to Bash
# verify below command
#SHELL ["/bin/bash", "-exo", "pipefail", "-c"]
SHELL ["/usr/bin/env", "bash", "-exo", "pipefail", "-c"]

ENV DEBIAN_FRONTEND	noninteractive
ENV HOME			/root
ENV PATH			$HOME/bin:$HOME/.local/bin:$PATH

RUN apt-get update && apt-get install -y \
		build-essential \
		ca-certificates \
		curl \
		git \
		gnupg \
		gzip \
		jq \
		locales \
		make \
		net-tools \
		netcat \
		openssh-client \
		parallel \
		software-properties-common \
		tar \
		unzip \
		wget \
		zip && \
	rm -rf /var/lib/apt/lists/*

# Install Docker - needs the setup_remote_docker CircleCI step to work
ENV DOCKER_VERSION 5:19.03.3~3-0~ubuntu-xenial
RUN apt-get update && apt-get install -y \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg-agent \
		software-properties-common && \
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
	add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
	apt-get update && \
	apt-get install -y docker-ce=${DOCKER_VERSION} docker-ce-cli=${DOCKER_VERSION} containerd.io && \
	# Quick test of the Docker install
	docker --version && \
	rm -rf /var/lib/apt/lists/*

# Install Docker Compose - see prerequisite above
ENV COMPOSE_VERSION 1.24.1
RUN curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
	chmod +x /usr/local/bin/docker-compose && \
	# Quick test of the Docker Compose install
	docker-compose version

# Install Dockerize v0.6.1
# Source repo: https://github.com/jwilder/dockerize
RUN curl -sSL --fail --retry 3 --output /tmp/dockerize-linux-amd64.tar.gz "https://circle-downloads.s3.amazonaws.com/circleci-images/cache/linux-amd64/dockerize-latest.tar.gz" && \
	tar -C /usr/local/bin -xzvf /tmp/dockerize-linux-amd64.tar.gz && \
	rm -rf /tmp/dockerize-linux-amd64.tar.gz && \
	# Quick test of Dockerize
	dockerize --version

# Set default shell for users
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y \
		locales \
		squashfs-tools \
		sudo && \
	rm -rf /var/lib/apt/lists/*

# Manually install the core snap, a dependency of the snapcraft snap as well 
# as the main point of this image.
RUN curl -L $(curl -H "X-Ubuntu-Series: 16" "https://api.snapcraft.io/api/v1/snaps/details/core" | jq ".download_url" -r) --output core.snap && \
	mkdir -p /snap/core && \
	unsquashfs -d /snap/core/current core.snap && \
	rm -f core.snap

# Manually install the snapcraft snap, so we can use it to build new snaps
RUN curl -L $(curl -H "X-Ubuntu-Series: 16" "https://api.snapcraft.io/api/v1/snaps/details/snapcraft?channel=stable" | jq ".download_url" -r) --output snapcraft.snap && \
	mkdir -p /snap/snapcraft && \
	unsquashfs -d /snap/snapcraft/current snapcraft.snap && \
	rm -f snapcraft.snap

# Install the Snapcraft runner
COPY snapcraft-wrapper /snap/bin/snapcraft

# Generate locale
RUN locale-gen en_US.UTF-8

# Set the proper environment
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV PATH=/snap/bin:$PATH

WORKDIR /root/project

# This run step is normally bad to have by itself however without it, users of 
# this image will need to manually run `apt-get update` before they can build 
# a majority of snaps. This increases build times which isn't good in CI.
# The echo statement allows us to break the cache for this step more easily 
# while also providing context.
RUN apt-get update && echo "Apt index last updated January 12, 2020 at the earliest."
