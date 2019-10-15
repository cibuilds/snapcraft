# vim:set ft=dockerfile:

# Ubuntu 18.04 based image to match the core18 snap
FROM cimg/base:2019.10

LABEL maintainer="Ricardo N Feliciano (FelicianoTech) <Ricardo@Feliciano.Tech>"

RUN apt-get update && apt-get install -y \
		locales \
		squashfs-tools \
		sudo && \
	rm -rf /var/lib/apt/lists/*

# Manually install the core snap, a dependency of the snapcraft snap
RUN curl -L $(curl -H "X-Ubuntu-Series: 16" "https://api.snapcraft.io/api/v1/snaps/details/core" | jq ".download_url" -r) --output core.snap && \
	mkdir -p /snap/core && \
	unsquashfs -d /snap/core/current core.snap && \
	rm -f core.snap

# Manually install the core18 snap, the main point of this image
RUN curl -L $(curl -H "X-Ubuntu-Series: 16" "https://api.snapcraft.io/api/v1/snaps/details/core18" | jq ".download_url" -r) --output core18.snap && \
	mkdir -p /snap/core18 && \
	unsquashfs -d /snap/core18/current core18.snap && \
	rm -f core18.snap

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
RUN apt-get update && echo "Apt index last updated October 13, 2019 at the earliest."
