output "vpc_id" {
  description = "vpc id is"
  value = aws_vpc.my-vpc.id
}

output "public_subnet"{
    value = aws_subnet.public-subnet.id
}