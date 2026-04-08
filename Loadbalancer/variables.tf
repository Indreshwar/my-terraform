#declaring a variable
variable "image-id" {
  type        = string
  default     = "ami-05d2d839d4f73aafb"
  description = "specify the AMI"

}
variable "ec2_instance_type" {
  type        = string
  default     = "t3.micro"
  description = "specify the instance type"

}