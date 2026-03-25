terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.37.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"

}
#creating an aws ec2 instance
resource "aws_instance" "FirstVM" {
  ami           = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"
  tags = {
    Name = "My_First_VM"
  }
}