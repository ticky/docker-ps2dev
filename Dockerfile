FROM ubuntu:12.04

MAINTAINER Jessica Stokes <hello@jessicastokes.net>

ENV TOOLCHAIN_VERSION a435ee0df19d8e07fa4c0a01f1f47fb7aeca834d

ENV PSPDEV /pspdev
ENV PSPSDK $PSPDEV/pspsdk
ENV PATH   $PATH:$PSPDEV/bin:$PSPSDK/bin

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        g++ \
        build-essential \
        autoconf \
        cmake \
        doxygen \
        bison \
        flex \
        libncurses5-dev \
        libsdl1.2-dev \
        libreadline-dev \
        libusb-dev \
        texinfo \
        libgmp3-dev \
        libmpfr-dev \
        libelf-dev \
        libmpc-dev \
        libfreetype6-dev \
        zlib1g-dev \
        libtool \
        subversion \
        git \
        tcl \
        unzip \
        wget \
    && echo "dash dash/sh boolean false" | debconf-set-selections \
    && dpkg-reconfigure --frontend=noninteractive dash \
    && git clone https://github.com/pspdev/psptoolchain.git /toolchain \
    && cd /toolchain \
    && git checkout -qf $TOOLCHAIN_VERSION \
    && ./toolchain.sh \
    && apt-get clean \
    && rm -rf \
        /pspdev/test.tmp \
        /toolchain \
        /var/lib/apt/lists/*

WORKDIR /src
CMD ["/bin/bash"]
