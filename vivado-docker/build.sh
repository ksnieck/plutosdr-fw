#!/bin/bash
set -x

# Download and extract the Vivado full installer in this dir

docker build -t vivado-base - <<EOF
FROM debian:stretch

# apt config:  silence warnings and set defaults
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# turn off recommends on container OS
# install required dependencies
RUN echo 'APT::Install-Recommends "0";\nAPT::Install-Suggests "0";' > \
    /etc/apt/apt.conf.d/01norecommend && \
    apt update && \
    apt -y install apt-utils && \
    apt -y install \
        bzip2 \
        libc6-i386 \
        git \
        libfontconfig1 \
        libglib2.0-0 \
        sudo \
	emacs screen \
        locales \
        libxext6 \
        libxrender1 \
        libxtst6 \
        libgtk2.0-0 \
        build-essential \
        unzip \
        pkg-config \
        libprotobuf-dev \
        protobuf-compiler \
        python-protobuf \
        python-pip \ 
	fakeroot libncurses5-dev ccache bc wget file cpio rsync \
	dfu-util u-boot-tools device-tree-compiler libssl1.0-dev mtools && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen && \
    apt clean && \
    apt autoremove && \
    rm -rf /var/lib/apt/lists/*
EOF

docker run -it  --name vivado-install -v `pwd`:/mnt vivado-base \
       /bin/bash /mnt/Xilinx_Vivado_SDK_2018.2_0614_1954/xsetup --batch Install \
       --agree XilinxEULA,3rdPartyEULA,WebTalkTerms \
       -c /mnt/xsetup_config_2018.2.txt
docker commit -m "Vivado 2018.2 installed in /opt/Xilinx on Debian Stretch" \
       vivado-install vivado:2018.2
docker rm vivado-install

