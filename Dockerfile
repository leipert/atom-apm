# DESCRIPTION:
#   Install dependencies for the atom editor package testing `apm test`.
# AUTHOR: Kenichi Kanai <kn1kn1@users.noreply.github.com>
# USAGE:
#   See the usage in the actual package building.
#   https://github.com/kn1kn1/language-context-free/blob/master/Dockerfile

# Atom Docker Image For Package Testing
FROM kn1kn1/atom-apm-test:latest
MAINTAINER Lukas Eipert <leipert@users.noreply.github.com>

# Make Sure We're Up To Date
RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    python-software-properties software-properties-common curl

# Add atom/nodejs ppa and install nodejs/atom
RUN \
  add-apt-repository ppa:webupd8team/atom && \
  curl -sL https://deb.nodesource.com/setup_0.12 | bash - && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nodejs atom=0.187.0-1~webupd8~0 -y && \
  apm --version

# Install gulp & grunt globally
RUN npm i -g gulp grunt-cli

# Cleanup
RUN \
  DEBIAN_FRONTEND=noninteractive \
    apt-get -y purge \
    python-software-properties software-properties-common curl apt-transport-https && \
  DEBIAN_FRONTEND=noninteractive apt-get -y autoremove && \
  DEBIAN_FRONTEND=noninteractive apt-get -y clean && \
  npm cache clean
