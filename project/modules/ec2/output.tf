output "instance_id" {
  description = "instance id  is"
  value = aws_instance.project-ec2.id
}

output "ec2_public_ip" {
  description = "ec2 public ip is"
  value = aws_instance.project-ec2.public_ip
}

output "ec2_private_ip" {
  description = "ec2 private ip is "
  value = aws_instance.project-ec2.private_ip
}

output "elastic_ip" {
  description = "elastic ip is"
  value = aws_eip.project-eip.public_ip
}