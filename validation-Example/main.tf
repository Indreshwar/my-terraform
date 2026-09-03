#declaring a variable
variable "image_id" {
  type = string
  default = "ami-01a00762f46d584a1"
  description = "enter the AMI id"
  #validation is a block require 2 manadatory arguments i.e condition & error message
  validation{
    condition = length(var.image_id) > 4 && substr(var.image_id,0,4) == "ami-"
    error_message = "The image id must be valid and it should start with \"ami-\" "
  } 
}
variable "instance_type" {
  type = string
  default = "t3.micro"
  description = "specify the instance type"
  validation {
    condition = can(regex("^[t][2-3].(nano|small|micro)",var.instance_type))  #can evaluates the expression return boolean value
    error_message = "invalid instance type"
  }
}
resource "aws_instance" "myserver" {
  ami           = var.image_id
  instance_type = var.instance_type
  tags = {
    Name = "my-server"
  }
}