#creating a default VPC its already present but terraform doesnot create the resource it add in state management
resource "aws_default_vpc" "myvpc" {
  tags = {
    Name = "default-VPC"
  }
}

#Creating a security group and adding ingress and egrees is old method but we are following the smae here
resource "aws_security_group" "mysg" {
  name        = "my-sg"
  description = "Allow SSH access "
  vpc_id      = aws_default_vpc.myvpc.id
  tags = {
    Name = "default-sg"
  }
  #ingress will create an inbound rule for security group
  ingress {
    description = "allow access through port-22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #egress will create an outbound rule 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "my-key" {
  key_name   = "mykey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCaRgl1MLucAeieZzMckF4WZTEKnXwTtZtBy3hhxd+M7hacfw0TMLn4/LddFiM3eRlXPQZrBJN50a0a9oQV6PmCYVxvYVEMjSMHi97gbScidn5kl0cjubQE5fOsR2Wn2fHnOKzZqQg4ul8/U1AEx+LktK9XRy1HfpDzRTIN0pdjaThRlR7s1BIBqEAX5+i39Q6QyPPGv8Rxivi5uJ+6z5jhsf5YdubpBvlNZa/9bsO9JovFVwwhcvUlsp3bCQ2SkoE1im57DW7KTPkCgE772nqPSv4YLuM3Q2qHhyFr5R24gXK2ja72KVAf7WOSG2BNMV5oXacwMBpc9AsfkRsgfhKp7S6EMwAFAFydx38UwT006CzqLMVBRJNL6QiSZ0W9agcouV3Ta7feEBqLyrf4/D0bf/BUJoxeAuso+qnOaMDzuTFpbkzWAjWjGW8KJjq45/DL8viwuAqRQmsjNwpPoZoA7d3G2p/NIgCy5J9xG8SyEtVLrs3Q9OJpVsM2BVgAVlE= acer@DESKTOP-1CCKMED"
}

#Creating an ec2 instance and we cam login to ec2 instance using my key
resource "aws_instance" "my-server" {
  ami                    = "ami-01a00762f46d584a1"
  instance_type          = "t3.small"
  key_name               = "mykey"
  vpc_security_group_ids = [aws_security_group.mysg.id]
  tags = {
    Name = "key-server"
  }
}
