# AWS VPC Infrastructure as Code with Terraform

This project demonstrates how to create and manage an Amazon Web Services (AWS) Virtual Private Cloud (VPC) infrastructure using Terraform. The code defines a VPC with both public and private subnets, sets up Internet connectivity, and launches Amazon Elastic Compute Cloud (EC2) instances in these subnets. With this Infrastructure as Code (IaC) approach, you can easily replicate and maintain your AWS VPC environment.

## Prerequisites

Before getting started, make sure you have the following prerequisites in place:

1. **AWS Account**: You will need an active AWS account with the necessary credentials.

2. **Terraform**: Ensure Terraform is installed on your local machine. You can download it [here](https://www.terraform.io/downloads.html).

3. **AWS CLI**: Install and configure the AWS Command Line Interface (CLI) for authenticating Terraform with your AWS account.

4. **SSH Key Pair**: Create an SSH key pair for securely accessing your EC2 instances.

## Usage

1. Clone this repository to your local machine:

   ```bash
   git clone <repository_url>
   cd aws-vpc-terraform

2. Initialize Terraform and download the required providers:
    ```bash
    terraform init
    terraform plan
    terraform apply

## Cleanup
To destroy the created resources and teardown the AWS VPC infrastructure, use the following command:

   ```bash
   terraform destroy -auto-approve
