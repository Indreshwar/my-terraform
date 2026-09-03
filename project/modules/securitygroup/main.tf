#creating a security group
resource "aws_security_group" "project-sg" {
  name = "${var.environment}-sg"
  vpc_id = var.vpc_id
  ingress {
    description = "Allow ssh access"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }
  ingress {
    description = "Allow http access"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.environment}-sg"
    Environment = var.environment
  }
}