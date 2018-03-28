FROM snapcore/snapcraft:stable

LABEL maintainer="Ricardo N Feliciano (FelicianoTech) <ricardo@feliciano.tech>"

RUN apt-get update && apt-get install -y \
	curl \
	git \
	jq \
	openssh-client \
	wget

WORKDIR /root/project
