resource "aws_instance" "server" {
  ami           = "ami-01a00762f46d584a1"
  instance_type = "t3.small"
  tags = {
    Name = "server-1"
  }
}