#!/bin/bash

# Update package 
sudo apt update

# Install Docker package
sudo apt install -y docker.io

# Install Git
sudo apt install -y git

# Install Docker-Compose
sudo apt install -y docker-compose

# Add current user to the docker group (to run Docker without sudo)
sudo usermod -aG docker $USER

# Start & enable the Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Clone Git repository
git clone https://github.com/k-mughal/dockerized-3-tier-app.git

# Change into the folder to execute docker-compose
cd dockerized-3-tier-app/3-tier-dockerized-app-on-aws/public-subnet

# Run Docker Compose with build
docker-compose up --build -d
