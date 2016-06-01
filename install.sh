#!/bin/sh
set -e

# download dependencies
apt-get update -y -qq
apt-get install -y --no-install-recommends \
  apt-transport-https \
  build-essential \
  apt-utils \
  ca-certificates \
  curl \
  erlang-dev \
  erlang-nox \
  git \
  haproxy \
  libcurl4-openssl-dev \
  libicu-dev \
  libmozjs185-dev \
  openssl \
  python
curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
echo 'deb https://deb.nodesource.com/node_4.x jessie main' > /etc/apt/sources.list.d/nodesource.list
echo 'deb-src https://deb.nodesource.com/node_4.x jessie main' >> /etc/apt/sources.list.d/nodesource.list
apt-get update -y -qq
apt-get install -y nodejs
npm install -g grunt-cli
cd /usr/src
git clone --depth 1 https://git-wip-us.apache.org/repos/asf/couchdb.git
cd couchdb
git checkout $COUCHDB_VERSION
./configure --disable-docs
make
apt-get purge -y \
    binutils \
    build-essential \
    apt-utils \
    cpp \
    erlang-dev \
    git \
    libicu-dev \
    make \
    nodejs \
    perl
apt-get autoremove -y
apt-get clean
apt-get install -y libicu52 --no-install-recommends
rm -rf /var/lib/apt/lists/* /usr/lib/node_modules src/fauxton/node_modules src/**/.git .git

# permissions
chmod +x /usr/src/couchdb/dev/run
