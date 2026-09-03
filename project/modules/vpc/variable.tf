variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type = string
}

variable "environment" {
  description = "environment value"
  type = string
}

variable "subnet_cidr" {
  description = "CIDR block for public subnet-1"
  type = string
}

variable "availability_zone" {
  description = "enter the availability zone"
  type = string
}