resource "aws_instance" "myserver" {
  ami           = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"
  key_name      = "terraform key"
  user_data     = <<-EOF
                 #!/bin/bash
                 echo " welcome to terraform " > file.txt
                EOF
  tags = {
    Name = "User-server"
  }

}