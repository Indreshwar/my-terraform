#creating a vpc
resource "aws_vpc" "jio-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  tags = {
    Name = "Jio-vpc"
  }
}
#creating an internet gateway
resource "aws_internet_gateway" "jio-igw" {
  vpc_id = aws_vpc.jio-vpc.id
  tags = {
    Name = "jio-igw"
  }
}
#creating a public subnet-1 
resource "aws_subnet" "jio-public-subnet-1" {
  vpc_id                  = aws_vpc.jio-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"
  tags = {
    Name = "Jio-public-subnet-1"
  }

}
#creating a public subnet-2
resource "aws_subnet" "jio-public-subnet-2" {
  vpc_id                  = aws_vpc.jio-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1b"
  tags = {
    Name = "jio-public-subnet-2"
  }

}
#creating a route table
resource "aws_route_table" "jio-RT" {
  vpc_id = aws_vpc.jio-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jio-igw.id
  }
  tags = {
    Name = "Jio-RT"
  }

}
#associating the public subnet-1 with the route table
resource "aws_route_table_association" "subnet1-RT-Association" {
  route_table_id = aws_route_table.jio-RT.id
  subnet_id      = aws_subnet.jio-public-subnet-1.id
}
#associating the public subnet-2 with the route table
resource "aws_route_table_association" "subnet2-RT-Association" {
  route_table_id = aws_route_table.jio-RT.id
  subnet_id      = aws_subnet.jio-public-subnet-2.id
}
#creating a security Group
resource "aws_security_group" "jio-sg" {
  name        = "jio-SG"
  description = "allow ssh and http access"
  vpc_id      = aws_vpc.jio-vpc.id
  ingress {
    description = "Allow ssh access through port-22"
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
#creating an iam role
resource "aws_iam_role" "jio-role" {
  name = "jio-role"
  #terraform jsonencode function converts a terraform epression into json format
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      }
    ]
  })
  tags = {
    Name = "Jio-Role"
  }

}
#creating a iam policy
resource "aws_iam_policy" "jio-policy" {
  name = "jio-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
      Effect = "Allow"
      Action = [
        "s3:*",
        "cloudwatch:*"
      ]
      Resource = "*"
    }
    ]
  })
}
#Attaching an iam policy to the iam role
resource "aws_iam_role_policy_attachment" "jio-attach" {
  role       = aws_iam_role.jio-role.name
  policy_arn = aws_iam_policy.jio-policy.arn

}
#creating an iam instance profile
resource "aws_iam_instance_profile" "jio-profile" {
  role = aws_iam_role.jio-role.name
  name = "jio-profile"

}

#creating an ec2 instance in public subnet-1
resource "aws_instance" "jio-server1" {
  ami                    = var.image-id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.jio-public-subnet-1.id
  key_name = "terraform key"
  iam_instance_profile   = aws_iam_instance_profile.jio-profile.name
  vpc_security_group_ids = [aws_security_group.jio-sg.id]
  user_data              = file("apache-1.sh")
  tags = {
    Name = "jio-server-1"
  }
}

#creating an ec2 instance in public subnet-2
resource "aws_instance" "jio-server2" {
  ami                    = var.image-id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.jio-public-subnet-2.id
  iam_instance_profile   = aws_iam_instance_profile.jio-profile.name
  vpc_security_group_ids = [aws_security_group.jio-sg.id]
  key_name = "terraform key"
  user_data              = file("apache-2.sh")
  tags = {
    Name = "jio-server-2"
  }

}
#creating a application load balancer
resource "aws_alb" "jio-LB" {
  name               = "jio-lb"
  internal           = false #because this server internet facing traffic and has public ip where if we keep true its used for internal traffic and has private ip 
  load_balancer_type = "application"
  security_groups    = [aws_security_group.jio-sg.id]
  subnets = [
    aws_subnet.jio-public-subnet-1.id,
    aws_subnet.jio-public-subnet-2.id
  ]
  tags = {
    Name = "Jio-LB"
  }
}
#creating a target group
resource "aws_alb_target_group" "jio-TG" {
  name        = "JIO-TG"
  protocol    = "HTTP" #protocol for communication b/w load balancer and targets
  port        = 80     #port where target recive traffic
  target_type = "instance"
  vpc_id      = aws_vpc.jio-vpc.id
  health_check {
    path = "/"
    port = "traffic-port"

  }
}
#registering targets to the target groups
resource "aws_alb_target_group_attachment" "jio-tg-attach1" {
  target_group_arn = aws_alb_target_group.jio-TG.arn
  target_id        = aws_instance.jio-server1.id
  port             = 80

}
#registering targets to the target groups
resource "aws_alb_target_group_attachment" "jio-tg-attach2" {
  target_group_arn = aws_alb_target_group.jio-TG.arn
  target_id        = aws_instance.jio-server2.id
  port             = 80

}
#creating a Load balancerlistner (a listener is procees that checks for connection requests using port and protocol we configure )
resource "aws_alb_listener" "jio-listener" {
  load_balancer_arn = aws_alb.jio-LB.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.jio-TG.arn
  }
}
