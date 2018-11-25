FROM snapcore/snapcraft:stable

LABEL maintainer="Ricardo N Feliciano (FelicianoTech) <Ricardo@Feliciano.Tech>"

RUN apt-get install -y \
	curl \
	git \
	jq \
	openssh-client \
	wget

WORKDIR /root/project
