FROM snapcore/snapcraft:beta

LABEL maintainer="Ricardo N Feliciano (FelicianoTech) <ricardo@feliciano.tech>"

RUN apt-get update && apt-get install -y \
	curl \
	git \
	openssh-client \
	wget

WORKDIR /root/project
