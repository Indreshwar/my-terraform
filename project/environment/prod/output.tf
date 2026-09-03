output "vpc_id" {
  description = "the vpc id is"
  value       = module.vpc.vpc_id
}

output "security_group_id" {
  description = "sg id is"
  value       = module.security-group.security_group_id
}

output "instance_id" {
  description = "instance id is"
  value       = module.ec2.instance_id
}

output "ec2_private_ip" {
  description = "private ip of ec2 is"
  value       = module.ec2.ec2_private_ip
}

output "elastic_ip" {
  description = "public ip of ec2"
  value       = module.ec2.elastic_ip
}