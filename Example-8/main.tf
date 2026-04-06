#creating a default vpc
resource "aws_default_vpc"  default{
    tags = {
        Name = "default-VPC"
    }
}
#creating a security Group
resource "aws_security_group" "mySG" {
    name = "MY-SG"
    description = "Allow access to SSH and HTTP"
    vpc_id = aws_default_vpc.default.id
    ingress {
        description = "Allow SSH access through port 22 "
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Allow HTTP access through port 80"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

#creating an ec2 instance
resource "aws_instance" "my-server" {
    ami = "ami-05d2d839d4f73aafb"
    instance_type = "t3.micro"
    key_name = "terraform key"
    vpc_security_group_ids = [aws_security_group.mySG.id]
    user_data = "${file("install-apache.sh")}"
    tags = {
      Name ="apache-server"
    }
  
}
