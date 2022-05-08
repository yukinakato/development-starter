#!/bin/bash

set -eu
cd ~

# Essentials
sudo apt update
sudo apt -y upgrade
sudo apt -y install curl git build-essential sqlite3 libsqlite3-dev zlib1g-dev libssl-dev

# C
# done by build-essential

# Go
wget -qO- https://go.dev/dl/go1.18.1.linux-amd64.tar.gz | tar xz -C ~/
eval $(echo 'export PATH="$HOME/go/bin:$PATH"' | tee -a ~/.bashrc)

# Node.js with nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.nvm/nvm.sh
nvm install --lts

# Ruby with rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv
src/configure
make -C src
cd ~
eval $(echo 'export PATH="$HOME/.rbenv/bin:$PATH"' | tee -a ~/.bashrc)
eval $(echo 'eval "$(rbenv init - bash)"' | tee -a ~/.bashrc)
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
rbenv install 2.7.6
rbenv global 2.7.6

# Ruby Gems
gem install -N rubocop solargraph nokogiri sqlite3

# git config
git config --global core.quotepath false
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager-core.exe"

# set default user for imported environment
sudo tee /etc/wsl.conf <<EOF
[user]
default=$(whoami)
EOF

cat <<EOF
*******************
* Setup finished. *
*******************
EOF
