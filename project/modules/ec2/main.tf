resource "aws_instance" "project-ec2" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Name = "${var.environment}-ec2"
    Environment = var.environment
  }
}

#creating an elastic ip
resource "aws_eip" "project-eip" {
  domain = "vpc"
  tags ={
    Name = "${var.environment}-eip"
    Environment = var.environment
  }
}

#creating an elastip ip association
resource "aws_eip_association" "project_eip_association" {
  instance_id = aws_instance.project-ec2.id
  allocation_id = aws_eip.project-eip.id
}