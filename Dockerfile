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

# Add atom ppa
RUN add-apt-repository ppa:webupd8team/atom

# Add nodejs ppa and install
RUN \
  curl -sL https://deb.nodesource.com/setup_0.12 | bash - && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

# Install Atom v0.187.0
RUN \
  DEBIAN_FRONTEND=noninteractive apt-get install atom=0.187.0-1~webupd8~0 -y

RUN \
  apm --version

# Install gulp & grunt globally
RUN npm i -g gulp grunt-cli
