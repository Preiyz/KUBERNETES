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

# Download and install aws-iam-authenticator
IAM_AUTHENTICATOR_VERSION="0.5.9"
IAM_AUTHENTICATOR_URL="https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v${IAM_AUTHENTICATOR_VERSION}/aws-iam-authenticator_${IAM_AUTHENTICATOR_VERSION}_linux_amd64"

echo "Downloading aws-iam-authenticator..."
curl -Lo aws-iam-authenticator "${IAM_AUTHENTICATOR_URL}"
chmod +x aws-iam-authenticator

echo "Installing aws-iam-authenticator..."
sudo mv aws-iam-authenticator /usr/local/bin/

# Add aws-iam-authenticator to the PATH
if ! grep -q '/usr/local/bin' "$HOME/.bashrc"; then
    echo 'export PATH="/usr/local/bin:$PATH"' >> "$HOME/.bashrc"
    source "$HOME/.bashrc"
fi

echo "AWS IAM Authenticator installed successfully!"

echo "The AWS IAM Authenticator is a command-line tool used for authentication and authorization to interact with AWS resources."
echo "It is required for authenticating and accessing an Amazon EKS (Elastic Kubernetes Service) cluster using AWS IAM credentials."
echo "By installing and configuring the AWS IAM Authenticator, you can manage and interact with Kubernetes clusters running on EKS."
echo "This script has downloaded and installed the AWS IAM Authenticator binary and added it to your PATH for easy access."
echo "You can now proceed with setting up and using EKS with proper authentication using the AWS IAM Authenticator."

