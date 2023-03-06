FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
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
    ccd2iso \
    docbook-xsl \
    gobject-introspection \
    cmake \
    ninja-build \
    nano \
    glslang-tools \
    libxml2-dev

# Sometimes Buildroot need proper locale, e.g. when using a toolchain
# based on glibc.
RUN locale-gen en_US.utf8

RUN git clone git://git.buildroot.net/buildroot --depth=1 --branch=master /root/buildroot

# install flutter/dart

RUN git clone https://github.com/flutter/flutter.git /var/lib/flutter/; chmod -R 777 /var/lib/flutter/
RUN ln -s /var/lib/flutter/bin/flutter /usr/bin/flutter; ln -s /var/lib/flutter/bin/dart /usr/bin/dart
RUN flutter config --enable-linux-desktop

# add dahlia specific files

RUN mkdir /root/buildroot/board/dahliaos
RUN mkdir /root/buildroot/dahliaOS-overlays
COPY add/board/dahliaos/* /root/buildroot/board/dahliaos/
COPY add/dahliaOS-overlays/ /root/buildroot/dahliaOS-overlays/
COPY add/package/ /root/buildroot/package/
COPY add/logo/logo.ppm /root/buildroot/logo/
COPY add/.config /root/buildroot/
COPY add/.config-old /root/buildroot/

WORKDIR /root/buildroot

ENV O=/buildroot_output

RUN touch .config
RUN touch kernel.config

VOLUME /root/buildroot/dl
VOLUME /buildroot_output

# copy the config also to /buildroot_output because it will use that config to build

COPY add/.config /buildroot_output/

RUN ["/bin/bash"]
