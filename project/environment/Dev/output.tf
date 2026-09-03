output "vpc_id" {
  description = "vpc id is"
  value       = module.vpc.vpc_id
}

output "subnet_id" {
  description = "subnet id is"
  value       = module.vpc.subnet_id
}

output "security_group_id" {
  value = module.securit-group.security_group_id
}

output "instance_id" {
  value = module.ec2.instance_id
}


output "ec2_private_ip" {
  value = module.ec2.ec2_private_ip
}

output "elastic_ip" {
  value = module.ec2.elastic_ip
}