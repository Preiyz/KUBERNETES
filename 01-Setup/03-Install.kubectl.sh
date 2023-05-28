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

# Download kubectl binary
echo "Downloading kubectl..."
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.7/2022-10-31/bin/linux/amd64/kubectl
echo "Download complete."

# Verify kubectl binary integrity
echo "Verifying kubectl integrity..."
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.26.4/2023-05-11/bin/linux/amd64/kubectl.sha256
if ! sha256sum -c kubectl.sha256; then
    display_error "Failed to verify the integrity of the downloaded kubectl binary."
fi
echo "Verification successful."

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

