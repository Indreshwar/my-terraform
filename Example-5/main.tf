#creating a default vpc
resource "aws_default_vpc" "my-vpc" {
  tags = {
    Name = "Default_my_vpc"
  }
}

#creating a security group
resource "aws_security_group" "my-sg" {
  name        = "my-security-group"
  description = "allow ssh and http access"
  vpc_id      = aws_default_vpc.my-vpc.id
  #creating an inbound rule
  ingress {
    description = "Allow ssh access through port-22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow http access through port-80"
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

#creating an instance
resource "aws_instance" "my-ec2" {
  ami                    = "ami-01a00762f46d584a1"
  instance_type          = "t3.small"
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  tags = {
    Name = "my-server"
  }
}

#creating an elastic ip
resource "aws_eip" "my-eip" {
  #domain indicates that this eip use in vpc
  domain = "vpc"
  tags = {
    Name = "my-eip"
  }
}

#creating an elasticip association
resource "aws_eip_association" "my-eip-association" {
  instance_id   = aws_instance.my-ec2.id
  allocation_id = aws_eip.my-eip.id
}