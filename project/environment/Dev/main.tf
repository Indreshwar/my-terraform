module "vpc" {
  source            = "../../modules/vpc"
  vpc_cidr          = var.vpc_cidr
  subnet_cidr       = var.subnet_cidr
  availability_zone = var.availability_zone
  environment       = "dev"
}

module "securit-group" {
  source      = "../../modules/securitygroup"
  vpc_id      = module.vpc.vpc_id
  ssh_cidr    = var.ssh_cidr
  environment = "dev"
}

module "ec2" {
  source            = "../../modules/ec2"
  ami               = var.ami
  instance_type     = var.instance_type
  subnet_id         = module.vpc.subnet_id
  security_group_id = module.securit-group.security_group_id
  environment       = "dev"

}