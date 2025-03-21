#!/bin/bash

# Update system packages
apt-get update -y
echo '* libraries/restart-without-asking boolean true' | debconf-set-selections
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get upgrade -y
apt-get install -y python3-minimal
timedatectl set-timezone Europe/Madrid

# Install Docker
apt-get install -y ca-certificates
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker and related packages
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
usermod -aG docker azureuser
