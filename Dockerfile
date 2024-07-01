# Use ubuntu:22.04 as the base image
FROM ubuntu:22.04

# Metadata and author information
LABEL org.opencontainers.image.authors="Mrw01f"

# Set non-interactive frontend for apt
ENV DEBIAN_FRONTEND=noninteractive

# Change directory to ELFEN directory
WORKDIR /home/elfen/ELFEN_DIR

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    git \
    python3 \
    python3-pip \
    openssl \
    python-is-python3 \
    ca-certificates \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Install Docker CLI and dependencies
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu focal stable" \
       | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io

# Verify Docker installation
RUN docker --version

# Clone ELFEN repository and handle cloning errors
RUN git clone --recursive https://github.com/nikhilh-20/ELFEN.git || \
    (echo "Failed to clone ELFEN repository"; exit 0)

RUN cd ./ELFEN

# Remove directories with failed git clone directories (if they exist)
RUN rm -rf ./ELFEN/rsrc/capa ./ELFEN/rsrc/ELFEN_images

# Clone submodules with error handling
RUN git clone --recursive https://github.com/nikhilh-20/ELFEN_images.git ./ELFEN/rsrc/ELFEN_images || \
    (echo "Failed to clone ELFEN_images submodule"; exit 0)

RUN git clone --recursive https://github.com/mandiant/capa.git ./ELFEN/rsrc/capa || \
    (echo "Failed to clone capa submodule"; exit 0)

# Generate secret key and replace in settings.py
RUN SECRET_KEY=$(openssl rand -base64 32) \
    && sed -i "s/django-insecure-elfen-sandbox/$SECRET_KEY/" ./ELFEN/ELFEN/settings.py

# Create necessary directories
RUN mkdir -p ./data/mysql \
    ./data/postgres \
    ./data/rabbitmq \
    ./media/web

# Build Docker Compose services
# Note: You should run docker-compose build in your host environment, not inside the Dockerfile.
# CMD ["docker-compose", "-f", "./docker-compose.yml", "-f", "./docker-compose.user.yml", "build"]

# Start Docker Compose services
CMD ["docker-compose", "-f", "./docker-compose.yml", "-f", "./docker-compose.user.yml", "up"]
