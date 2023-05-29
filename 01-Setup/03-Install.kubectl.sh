#!/bin/bash

set -euo pipefail

# Function to display error messages
display_error() {
    echo "Error: $1" >&2
    exit 1
}

# Check if running on Ubuntu 20.04
if [[ "$(lsb_release -rs)" != "20.04" ]]; then
    display_error "This script is intended for Ubuntu 20.04 only."
fi

# Update the server
echo "Updating the server..."
sudo apt-get update > /dev/null
echo "Server update complete."

# Install necessary dependencies
echo "Installing dependencies..."
sudo apt-get install -y apt-transport-https ca-certificates curl > /dev/null
echo "Dependencies installed successfully."

# Download kubectl binary
echo "Downloading kubectl..."
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
echo "Download complete."

# Install kubectl
echo "Installing kubectl..."
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
echo "kubectl installed successfully!"

# Add kubectl to PATH
echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
source ~/.bashrc

# Display kubectl version
echo "kubectl version:"
kubectl version --short --client

echo "KUBECTL INSTALLED SUCCESSFULLY!"

