# DESCRIPTION:
#   Install dependencies for the atom editor package testing `apm test`.
# AUTHOR: Kenichi Kanai <kn1kn1@users.noreply.github.com>
# USAGE:
#   See the usage in the actual package building.
#   https://github.com/kn1kn1/language-context-free/blob/master/Dockerfile

# Atom Docker Image For Package Testing
FROM ubuntu:trusty
MAINTAINER Kenichi Kanai <kn1kn1@users.noreply.github.com>

# Make Sure We're Up To Date
RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y

# Install Required Packages For Atom
RUN \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    gconf2 \
    gconf-service \
    libgtk2.0-0 \
    libnotify4 \
    libxtst6 \
    libnss3 \
    python \
    gvfs-bin \
    xdg-utils \
    --no-install-recommends

#  For downloading deb
RUN \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    wget \
    ca-certificates \
    --no-install-recommends

#  For apm install
RUN \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    make \
    g++ \
    --no-install-recommends

#  For apm test
RUN  \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    xvfb \
    libasound2 \
    --no-install-recommends

RUN \
  rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
