output "vpc_id" {
  description = "vpc id is"
  value = aws_vpc.project_vpc.id
}

output "subnet_id" {
  description = "subnet id is"
  value = aws_subnet.public_subnet_1.id
}