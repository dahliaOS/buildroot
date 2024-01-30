FROM ubuntu:latest

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    build-essential \
    bash \
    bc \
    binutils \
    bzip2 \
    cpio \
    g++ \
    gcc \
    git \
    gzip \
    locales \
    libncurses5-dev \
    libdevmapper-dev \
    libsystemd-dev \
    make \
    mercurial \
    whois \
    patch \
    perl \
    python3 \
    python3-dev \
    rsync \
    sed \
    tar \
    vim \ 
    unzip \
    zip \
    wget \
    curl \
    bison \
    flex \
    file \
    libssl-dev \
    libfdt-dev \
    libgtk-3-dev \
    clang \
    syslinux-utils \
    libelf-dev  

# Sometimes Buildroot need proper locale, e.g. when using a toolchain
# based on glibc.
RUN locale-gen en_US.utf8

ENV USER root 

RUN git clone git://git.buildroot.net/buildroot --depth=1 --branch=master /root/buildroot

# copy and run the flutter manager script
COPY scripts/dahlia_flutter_manager.sh /root/dahlia_flutter_manager.sh
RUN bash ./root/dahlia_flutter_manager.sh install

COPY buildroot/.config /root/buildroot/.config
# copy the config also to /buildroot_output because it will use that config to build
COPY buildroot/.config /buildroot_output/

WORKDIR /root/buildroot

RUN ["/bin/bash"]