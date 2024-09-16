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
key_name = "iac-first-main-tf"
  tags = {
    Name = "First Instance"
  }
}