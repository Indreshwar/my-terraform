#we are creating module bloc and giving the name as vpc
module "vpc" {
  source            = "../../modules/vpc"
  vpc_cidr          = var.vpc_cidr #in VPC module we are giving the vpc_cidr value so
  subnet_cidr       = var.subnet_cidr
  availability_zone = var.availability_zone
  environment       = "dev"
}