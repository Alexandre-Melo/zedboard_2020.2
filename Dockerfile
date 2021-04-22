FROM ubuntu:18.04
LABEL maintainer="abmelo@gmail.com"

# Essential Packages
RUN apt-get update && apt-get -y upgrade && apt-get install -y \
	build-essential \
	chrpath \
	cpio \
	curl \
	debianutils \
	diffstat \
	gawk \
	gcc-multilib \
	git-core \
	iputils-ping \
	locales \
	openssh-server \
	python \
	python3 \
	python3-pip \
	python3-pexpect \
	socat \
	subversion \
	tar \
	texinfo \
	unzip \
	vim \
	xz-utils \
	xterm \
	wget

# Cleans up apt cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Replaces dash with bash
RUN rm /bin/sh && ln -s bash /bin/sh

# Sets Locale
RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV USER_NAME auser

ARG host_uid=1002
ARG host_gid=1002

RUN groupadd -g $host_gid $USER_NAME && useradd -g $host_gid -m -s /bin/bash -u $host_uid $USER_NAME
USER $USER_NAME

# Sets up build directories
ENV BUILD_DIR /home/$USER_NAME/yocto/
RUN mkdir -p $BUILD_DIR

WORKDIR $BUILD_DIR
ENV TEMPLATECONF=$BUILD_DIR/yocto/meta-mysetup/conf
