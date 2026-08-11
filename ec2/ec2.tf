terraform {
  required_providers {
     aws = {
      source = "hashicorp/aws"
      version = "6.58.0"
     }
  }
}

#provider block
provider "aws" {
  region ="ap-south-1"
}

#create an instance
resource "aws_instance" "server" {
  ami= "ami-01a00762f46d584a1"
  instance_type = "t3.small"
  tags = {
    Name = "My-server"
  }
  
}