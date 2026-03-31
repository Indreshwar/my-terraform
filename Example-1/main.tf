resource "aws_instance" "my-server" {
  ami           = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"
  tags = {
    Name = "MyServer"
  }

}