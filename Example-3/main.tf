#creating a default vpc
resource "aws_default_vpc" "myvpc" {
  tags = {
    Name = "My-Default-VPC"
  }
}
#creating a security Group
resource "aws_security_group" "mySG" {
  name        = "my-SG"
  description = "which allow access to ssh and HTTP"
  vpc_id      = aws_default_vpc.myvpc.id
  #creating an inbound rule in security group
  ingress {
    description = "allow access to ssh through port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #creating an inbound rule in security group
  ingress {
    description = "allow access to http through port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #creating an outbound rule in security group
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#creating an ec2 instance
resource "aws_instance" "My-server" {
  ami           = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"
  #we are attaching the security group which created above
  vpc_security_group_ids = [aws_security_group.mySG.id]
  tags = {
    Name = "My_server"
  }
}
