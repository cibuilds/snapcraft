# vim:set ft=dockerfile:

# Ubuntu 20.04 based image to match the core20 snap
FROM cimg/base:2020.08-20.04

LABEL maintainer="Ricardo N Feliciano (FelicianoTech) <Ricardo@Feliciano.Tech>"

RUN sudo apt-get update && sudo apt-get install -y \
		squashfs-tools && \
	sudo rm -rf /var/lib/apt/lists/*

# Manually install the core18 snap, a dependency of the snapcraft snap
RUN curl -L $(curl -H "X-Ubuntu-Series: 16" "https://api.snapcraft.io/api/v1/snaps/details/core18" | jq ".download_url" -r) --output core18.snap && \
	sudo mkdir -p /snap/core18 && \
	sudo unsquashfs -d /snap/core18/current core18.snap && \
	rm -f core18.snap

# Manually install the core20 snap, the main point of this image
RUN curl -L $(curl -H "X-Ubuntu-Series: 16" "https://api.snapcraft.io/api/v1/snaps/details/core20" | jq ".download_url" -r) --output core20.snap && \
	sudo mkdir -p /snap/core20 && \
	sudo unsquashfs -d /snap/core20/current core20.snap && \
	rm -f core20.snap

# Manually install the snapcraft snap, so we can use it to build new snaps
RUN curl -L $(curl -H "X-Ubuntu-Series: 16" "https://api.snapcraft.io/api/v1/snaps/details/snapcraft?channel=stable" | jq ".download_url" -r) --output snapcraft.snap && \
	sudo mkdir -p /snap/snapcraft && \
	sudo unsquashfs -d /snap/snapcraft/current snapcraft.snap && \
	rm -f snapcraft.snap

# Install the Snapcraft runner
COPY snapcraft-wrapper /snap/bin/snapcraft

# Set the proper environment
ENV PATH=/snap/bin:$PATH

# This run step is normally bad to have by itself however without it, users of 
# this image will need to manually run `apt-get update` before they can build 
# a majority of snaps. This increases build times which isn't good in CI.
# The echo statement allows us to break the cache for this step more easily 
# while also providing context.
RUN sudo apt-get update && echo "Apt index last updated August 22nd, 2020 at the earliest."
