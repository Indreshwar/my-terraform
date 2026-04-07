#declaring a variable
variable "ec2_instance_type" {
  type        = string
  default     = "t3.micro"
  description = "specify the instance type"

}
variable "ami_id" {
  type        = string
  default     = "ami-05d2d839d4f73aafb"
  description = "Specify AMI"

}
variable "tags_name" {
  type        = string
  default     = "server-1"
  description = "specify the tag for server"

}
#creating an instance
resource "aws_instance" "server1" {
  ami           = var.ami_id #calling a variable
  instance_type = var.ec2_instance_type
  tags = {
    Name = var.tags_name
  }

}