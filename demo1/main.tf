# This terraform script will create an EC2 instance on the existing AssignmentVPC and WebSecurityGroup/PublicWebSubnet
# 2 alterative AMI examples are used here to show updating the images. 
#
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.69"
    }
  }
  required_version = ">= 1.16.3"
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

# Latest Ubuntu 24.04 AMI
data "aws_ssm_parameter" "ubuntu_linux_ami" {
  #name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
  name = "/aws/service/canonical/ubuntu/server/26.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

# Look up the pre-existing VPC by its Name tag
data "aws_vpc" "assignment_vpc" {
  filter {
    name   = "tag:Name"
    values = ["AssignmentVPC"]
  }
}

# Look up the pre-existing Subnet inside your VPC by its Name tag
data "aws_subnet" "public_web_subnet" {
  vpc_id = data.aws_vpc.assignment_vpc.id
  
  filter {
    name   = "tag:Name"
    values = ["PublicWebSubnet"]
  }
}

# Look up the pre-existing Security Group by its Name tag and VPC
data "aws_security_group" "web_sg" {
  vpc_id = data.aws_vpc.assignment_vpc.id

  filter {
    name   = "tag:Name"
    values = ["WebSecurityGroup"]
  }
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ssm_parameter.ubuntu_linux_ami.value
  instance_type = "t2.nano"
  
  # Placed inside your specific public subnet
  subnet_id     = data.aws_subnet.public_web_subnet.id

  # Associated with your specific Web Security Group
  vpc_security_group_ids = [data.aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name = "3tierassignment"

  tags = {
    Name = "ATUExampleAppServerInstance"
  }
}
output "instance_public_ip" {
  description = "The public IP address of the web server"
  value       = aws_instance.app_server.public_ip
}