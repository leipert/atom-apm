# Atom apm

## Overview
Installs the [Atom editor](http://atom.io/) in the latest version.
Gives you the possibility to run commands like `apm test` or `apm install`.

Comes with node, grunt & gulp preinstalled

## Usage

With docker:

```yml
FROM leipert/atom-apm:latest
# Add Package To `/root` Dir
ENV HOME /root
ADD . $HOME
WORKDIR /root

# Install Package Dependencies
RUN apm install

# Start the Xvfb server with a display 99 and a virtual screen(monitor) 0.
RUN \
  start-stop-daemon --start --pidfile /tmp/xvfb_99.pid --make-pidfile \
    --background --exec /usr/bin/Xvfb -- :99 -screen 0 1024x768x24 -ac \
    +extension GLX +extension RANDR +render -noreset && \
  sleep 3 && \
  export DISPLAY=:99 && \
  apm test
```

With wercker ewok:

```yml
box: leipert/atom-apm
# Build definition
build:
  # The steps that will be executed on build
  steps:
    - npm-install
    - script:
        name: Run gulp
        code: gulp
    - script:
        name: Test package
        code: >
          start-stop-daemon --start --pidfile /tmp/xvfb_99.pid --make-pidfile
          --background --exec /usr/bin/Xvfb -- :99 -screen 0 1024x768x24 -ac
          +extension GLX +extension RANDR +render -noreset &&
          sleep 3 &&
          export DISPLAY=:99 &&
          apm test
```
