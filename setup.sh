#!/bin/bash

set -eu

# Essentials
sudo apt -y install curl git build-essential sqlite3 libsqlite3-dev zlib1g-dev libssl-dev ca-certificates gnupg lsb-release

# C
# done by build-essential

# Go
wget -qO- https://go.dev/dl/go1.17.3.linux-amd64.tar.gz | tar xz -C ~/
eval $(echo 'export PATH="$HOME/go/bin:$PATH"' | tee -a ~/.bashrc)

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
eval $(echo 'export PATH="$HOME/.rbenv/bin:$PATH"' | tee -a ~/.bashrc)
eval $(echo 'eval "$(rbenv init - bash)"' | tee -a ~/.bashrc)
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

# xrdp
sudo apt -y install xrdp
sudo tee /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla <<EOF
[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile
ResultAny=no
ResultInactive=no
ResultActive=yes
EOF
cat <<EOF > ~/.xsessionrc
export DESKTOP_SESSION=ubuntu
export GNOME_SHELL_SESSION_MODE=ubuntu
export XDG_CURRENT_DESKTOP=ubuntu:GNOME
EOF
sudo tee -a /etc/pam.d/xrdp-sesman <<EOF
auth optional pam_gnome_keyring.so
session optional pam_gnome_keyring.so auto_start
EOF

cat <<EOF
*******************
* Setup finished. *
*******************
EOF
