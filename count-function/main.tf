#creating an instance
resource "aws_instance" "server" {
  ami           = "ami-048f4445314bcaa09"
  instance_type = "t3.micro"
  count         = 3
  tags = {
    Name = "Server-${count.index}"
  }
}