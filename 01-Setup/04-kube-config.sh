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

# Get the caller identity to check AWS credentials
echo "Checking AWS credentials..."
aws sts get-caller-identity > /dev/null 2>&1 || display_error "AWS authentication failed. Please check your credentials."

# Collect cluster name from user
echo "Please enter the name of your cluster:"
read -r cluster

# Update kubeconfig for the specified cluster
echo "Updating kubeconfig..."
aws eks update-kubeconfig --region us-east-1 --name "$cluster" || display_error "Failed to update kubeconfig."

echo "Kubeconfig updated successfully!"

