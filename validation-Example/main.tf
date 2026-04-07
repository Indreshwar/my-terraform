#declaring a variable
variable "image_id" {
  type        = string
  default     = "ami-05d2d839d4f73aafb"
  description = "specify the image id"
  #validation block require 2 arguments mandatory is condition & error_message
  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id must be valid AMI starting with \"ami-\" "
  }
}
variable "ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "specify the instance type to be used"
  validation {
    condition     = can(regex("^[t][2-3].(nano|small|micro)", var.ec2_instance_type))
    error_message = "invalid instance type"
  }

}
resource "aws_instance" "myserver" {
  ami           = var.image_id
  instance_type = var.ec2_instance_type
  tags = {
    Name = "my-server"
  }
}