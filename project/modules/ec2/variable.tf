variable "ami" {
  description = "ami value is "
  type = string
}

variable "instance_type" {
  description = "instance type"
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "environment" {
  type = string
}