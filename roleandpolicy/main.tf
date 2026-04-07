#creating a default vpc
resource "aws_default_vpc" "myvpc" {
  tags = {
    Name = "my-default-vpc"
  }

}
#creating a security group
resource "aws_security_group" "mySG" {
  name        = "my-SG"
  description = "Allow SSH access"
  vpc_id      = aws_default_vpc.myvpc.id
  #creating an inbound rule
  ingress {
    description = "Allow ssh access through port-22"
    from_port   = 22
    to_port     = 22
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
resource "aws_iam_role" "my-role" {
  name = "my-role"
  #terraform jsonencode function converts a terraform epression into json format
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    tag-key = "my_role"
  }

}
#creating a policy
resource "aws_iam_policy" "my-policy" {
  name = "demo-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:*"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

#Attaching a ploicy to the role
resource "aws_iam_role_policy_attachment" "demo-attach" {
  role       = aws_iam_role.my-role.name
  policy_arn = aws_iam_policy.my-policy.arn

}

#creating an instance profile
resource "aws_iam_instance_profile" "my-profile" {
  name = "my-profile"
  role = aws_iam_role.my-role.name

}
#creating a instance
resource "aws_instance" "role-policy-server" {
  ami                    = "ami-05d2d839d4f73aafb"
  instance_type          = "t3.micro"
  iam_instance_profile   = aws_iam_instance_profile.my-profile.name
  key_name               = "terraform key"
  vpc_security_group_ids = [aws_security_group.mySG.id]
  tags = {
    Name = "role-policy-server"
  }

}