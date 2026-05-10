#!/usr/bin/env bash
# Script Name: docker-debian.sh
# Description: Add the repository and install Docker Engine
# Version: 1.0
# Author: Bruno Baier
# Email: baierbdev@yandex.com
# Date: 2026-03-13

if [[ $UID != 0 ]];then
    echo "Run this script using sudo: sudo $0 "
    exit 1
fi

# Installing dependencies and setup keyring
apt update && sudo apt install ca-certificates curl -y
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg \
    -o /etc/apt/keyrings/docker.asc


# Configure the source.list
tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

# Update and install Docker engine
apt update
apt install docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin -y

echo <<EOF 
"Run this command after installation to be able to use the docker command
with a ordinary user"
EOF

