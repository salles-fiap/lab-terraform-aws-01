# lab-terraform-aws-01
# AWS EC2 Terraform Configuration

This project demonstrates how to use Terraform to define and deploy an AWS EC2 instance. The configuration utilizes the AWS provider to set up a `t2.micro` instance with a specified AMI for Ubuntu 22.04 LTS.

## Prerequisites

- Terraform (>= 1.2.0)
- AWS Account
- AWS CLI configured with necessary access
- A key pair created (replace `key_name` in the Terraform configuration with your own key name)

## Configuration

### Terraform script (`main.tf`):

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0928f4202481dfdf6" # AMI Ubuntu 22.04 LTS
  instance_type = "t2.micro"
  key_name      = "iac-first-main-tf"

  tags = {
    Name = "First Instance"
  }
}

Steps to Set Up
Create the project directory:

bash
Copiar código
$ mkdir learn-terraform-aws-instance
$ cd learn-terraform-aws-instance
Create and edit the configuration file:

bash
Copiar código
$ touch main.tf
Paste the above Terraform configuration into main.tf.

Initialize Terraform in the directory:

bash
Copiar código
$ terraform init
Validate the configuration:

bash
Copiar código
$ terraform validate
Apply the configuration to create the EC2 instance:

bash
Copiar código
$ terraform apply
Inspect the Terraform state:

bash
Copiar código
$ terraform show
Troubleshooting
If you're using a region other than us-west-2, make sure to update the AMI ID for your desired region.
Ensure that you have a valid AWS key pair, and update the key_name field in the main.tf file with the correct key name.