#!/bin/bash

set -eu

# Essentials
sudo apt -y install curl git build-essential sqlite3 libsqlite3-dev zlib1g-dev libssl-dev ca-certificates gnupg lsb-release

# C
# done by build-essential

# Go
wget -qO- https://go.dev/dl/go1.17.3.linux-amd64.tar.gz | tar xz -C ~/
echo 'export PATH="$HOME/go/bin:$PATH"' >> ~/.bashrc

# Node.js with nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.nvm/nvm.sh
nvm install --lts

# Ruby with rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv
src/configure
make -C src
cd ~
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
~/.rbenv/bin/rbenv init
echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc
source ~/.bashrc
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
rbenv install 2.7.5
rbenv global 2.7.5

# Ruby Gems
gem install -N rubocop solargraph nokogiri sqlite3

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt -y install docker-ce docker-ce-cli containerd.io
