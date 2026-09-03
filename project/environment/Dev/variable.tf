variable "vpc_cidr" {
  description = "vpc cidr"
  type        = string
}

variable "subnet_cidr" {
  description = "subnet cidr"
  type        = string
}

variable "availability_zone" {
  description = "mention the availability zone"
  type        = string
}

variable "region" {
  description = "enter the region"
  type        = string
}

variable "ssh_cidr" {
  description = "enter the ssh cidr range"
  type        = string
}

variable "ami" {
  description = "image id"
  type        = string
}

variable "instance_type" {
  description = "instance type is"
  type        = string
}


