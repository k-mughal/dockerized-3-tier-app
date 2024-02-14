#! /bin/bash
# Instance Identity Metadata Reference - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-identity-documents.html

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
cd dockerized-3-tier-app/3-tier-dockerized-app-on-aws/private-subnet

export DB_NAME="${terraform.output.db_name}"
export DB_HOST="${terraform.output.db_host}"
export DB_PORT="${terraform.output.db_port}"
export DB_USER="${terraform.output.db_user}"
export DB_PASSWORD="${terraform.output.db_password}"


# Run Docker Compose with build
docker-compose up --build -d
