#creating a default vpc
resource "aws_default_vpc" "my-vpc" {
  tags = {
    Name = "my-vpc"
  }
}

#creating a security group with inbound and outbound rules
resource "aws_security_group" "my-sg" {
  name        = "my-SG"
  description = "Allow SSH & HTTP Access"
  vpc_id      = aws_default_vpc.my-vpc.id
  #creating an inbound rule
  ingress {
    description = "allow ssh access through port-22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow http access through port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#creating a instance
resource "aws_instance" "my-server" {
  ami                    = "ami-01a00762f46d584a1"
  instance_type          = "t3.small"
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  tags = {
    Name = "sg-server"
  }
}