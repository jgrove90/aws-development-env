#!/bin/bash

# Update package lists and upgrade installed packages
sudo apt-get update -y
sudo apt-get upgrade -y

# Install required packages for Docker
sudo apt-get install -y \
docker.io \
python3

# Add the current user to the docker group
sudo usermod -aG docker $USER
