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

# Check if AWS CLI is already installed
if command -v aws &>/dev/null; then
    echo "AWS CLI is already installed. Checking for updates..."
    sleep 2
    aws --version
    sudo ./aws/install --update
    echo "AWS CLI updated successfully!"
else
    # Install AWS CLI
    echo "Installing AWS CLI..."
    sleep 2
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" > /dev/null
    sudo apt-get install -y unzip > /dev/null
    unzip awscliv2.zip > /dev/null
    sudo ./aws/install
    echo "AWS CLI installed successfully!"
fi

# Explanation of AWS CLI
echo
echo "The AWS Command Line Interface (CLI) is a unified tool to manage your AWS services from the command line."
echo "With the AWS CLI, you can control multiple AWS services and automate them through scripts."
echo

# Collect AWS credentials
echo "Please get your access key and secret key to authenticate with AWS."
echo "Please type 'Ready' when you have both information."

while true; do
    read -p "Are you ready? " answer

    if [[ $answer == "Ready" ]]; then
        read -p "Please enter your AWS Access Key: " access_key
        read -p "Please enter your AWS Secret Key: " secret_key
        break
    else
        echo "Invalid input. Please type 'Ready' when you are ready."
    fi
done

echo "Moving forward with AWS authentication..."

# Configure AWS CLI
echo -e "$access_key\n$secret_key\nus-east-1\njson" | aws configure
# Replace "us-east-1" with the desired AWS region if needed.
# The last "json" option sets the output format to JSON, modify it if you prefer a different format.

echo
echo "Your AWS account has been configured successfully."
echo "You can proceed to the next steps."

# Remove downloaded zip file and unpacked folder
rm -f awscliv2.zip
rm -rf aws

