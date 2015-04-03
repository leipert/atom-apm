#/bin/bash

echo "Installing $1"
dpkg -i $1 > /dev/null 2>&1
if [ $? -gt 0 ]; then
  echo "Installing $1 dependencies"
  DEBIAN_FRONTEND=noninteractive apt-get -fyqq install --no-install-recommends > /dev/null
fi
