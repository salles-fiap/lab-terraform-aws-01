Infrastructure and Deployment Automation
This project demonstrates the use of Terraform, Ansible, and AWS to automate the provisioning and configuration of an application server with Django. The setup includes Terraform for infrastructure provisioning, Ansible for configuration management, and AWS as the cloud provider.

Project Structure
main.tf - Terraform configuration for provisioning an AWS EC2 instance.
hosts.yml - Ansible inventory file specifying the target server.
playbook.yml - Ansible playbook for setting up Python, Django, and configuring the project.
.gitignore - Specifies files and directories to be ignored by Git.
Terraform Configuration
main.tf
This file contains the Terraform configuration for provisioning an EC2 instance on AWS.

hcl
Copiar código
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

  # Uncomment the following lines if you want to initialize a simple HTTP server
  # user_data = <<-EOF
  # #!/bin/bash
  # cd /home/ubuntu
  # echo "<h1>Feito com Terraform</h1>" > index.html
  # nohup busybox httpd -f -p 8080 &
  # EOF

  tags = {
    Name = "Python + Ansible + Terraform + AWS"
  }
}
Ansible Configuration
hosts.yml
The Ansible inventory file that specifies the target server for configuration.

ini
Copiar código
[terraform-ansible]
34.217.146.221
playbook.yml
The Ansible playbook to set up Python, virtualenv, Django, and configure the Django project.

yaml
Copiar código
- name: Setup Python and Virtualenv
  hosts: terraform-ansible
  become: yes
  tasks:
    - name: Update apt cache and install python3, virtualenv
      apt:
        pkg:
          - python3
          - python3-pip
          - virtualenv
        update_cache: yes

    - name: Create a virtual environment
      command: virtualenv /home/ubuntu/lab/venv

    - name: Install Django and Django Rest Framework in virtualenv
      pip:
        virtualenv: /home/ubuntu/lab/venv
        name: 
          - django
          - djangorestframework

    - name: Start Django project
      shell: |
        . /home/ubuntu/lab/venv/bin/activate
        django-admin startproject setup /home/ubuntu/lab

    - name: Changing the ALLOWED_HOSTS in the settings file
      lineinfile:
        path: /home/ubuntu/lab/setup/settings.py
        regexp: '^ALLOWED_HOSTS = .*'
        line: 'ALLOWED_HOSTS = ["*"]'
        backrefs: yes
Git Ignore
.gitignore
Specifies files and directories to be ignored by Git.

gitignore
Copiar código
### Terraform ###
# Local .terraform directories
**/.terraform/*

# .tfstate files
*.tfstate
*.tfstate.*

# Keys
*.pem
Setup Instructions
Provision the Infrastructure

Run terraform init to initialize the Terraform configuration.
Run terraform apply to provision the AWS EC2 instance.
Configure the Server

Ensure you have Ansible installed and the inventory file (hosts.yml) configured with your server's IP.
Run ansible-playbook playbook.yml -u ubuntu --private-key iac-alura.pem -i hosts.yml to set up Python, virtualenv, Django, and configure the project.
Verify the Setup

SSH into your EC2 instance and verify the setup. You can access the Django application on the public IP of your EC2 instance at port 8000.
Diagrams
Architecture Diagram

Django Project Setup