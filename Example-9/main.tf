#creating an iam role
resource "aws_iam_role" "test_role" {
  name = "test-role"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
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
    tag-key = "test-role"
  }
}
#attaching an managed iam policy to iam role
resource "aws_iam_role_policy_attachment" "demo-attach" {
  role       = aws_iam_role.test_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"

}

#creating an instance profile
resource "aws_iam_instance_profile" "demo-profile" {
  name = "demo-profile"
  role = aws_iam_role.test_role.name

}

#creating an instance
resource "aws_instance" "role-server" {
  ami           = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"
  #attaching an created role to ec2 instance
  iam_instance_profile = aws_iam_instance_profile.demo-profile.name
  key_name             = "terraform key"
  tags = {
    Name = "role-server"
  }

}