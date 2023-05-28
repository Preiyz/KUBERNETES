# AWS EKS Cluster Setup

This repository provides instructions and scripts for setting up an Amazon EKS cluster and configuring additional components.

## Table of Contents

- [Prerequisites](#prerequisites)
- [IAM User Setup](#iam-user-setup)
- [VPC and Network Component Creation](#vpc-and-network-component-creation)
- [EKS Cluster Creation](#eks-cluster-creation)
- [Adding Worker Nodes](#adding-worker-nodes)
- [Accessing the EKS Cluster](#accessing-the-eks-cluster)

## Prerequisites

Before proceeding, ensure that you have the following:

- An AWS account
- AWS CLI installed and configured
- IAM user credentials with necessary permissions

## IAM User Setup

1. Sign in to the AWS Management Console.
2. Search for "IAM" and select "IAM" from the services.
3. Create a new IAM user with programmatic access and attach the necessary policies.
4. Save the Access Key ID and Secret Access Key of the IAM user for future use.

## VPC and Network Component Creation

1. Search for "CloudFormation" in the AWS Management Console.
2. Upload the provided YAML file or use the S3 bucket link to create the VPC components.
3. Follow the instructions and create the CloudFormation stack.
4. Wait for the stack creation to complete.

## EKS Cluster Creation

1. Search for "EKS" in the AWS Management Console.
2. Create a new EKS cluster and provide a name for the cluster.
3. Select the appropriate cluster role that you previously created.
4. Configure the cluster settings, including VPC, subnets, and cluster endpoint access.
5. Review the settings and create the EKS cluster.

## Adding Worker Nodes

1. Launch an EC2 instance with the desired specifications.
2. Install the AWS CLI, AWS IAM authenticator, and Kubectl on the EC2 instance.
3. Clone the provided repository and use the bash script for installation.
4. Configure the worker node security group to allow inbound traffic from the EKS control plane.
5. Connect to the EC2 instance and execute the necessary commands to register the worker nodes with the EKS cluster.
6. Wait for the worker nodes to join the cluster.

## Accessing the EKS Cluster

1. Use the AWS CLI to authenticate with the EKS cluster using the IAM user credentials.
2. Verify the cluster connection by running `kubectl get nodes` command.
3. You can now manage and deploy workloads on the EKS cluster.

For more detailed instructions and information, refer to the individual sections above.


