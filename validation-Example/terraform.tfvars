instance_type = "t3.small"
image_id          = "ami-01a00762f46d584a1"

#terraform.tfvars will have high priority than the default values in variables.tf

#priority
#high priority - which we give through cli ex terraform apply -var="ec2_instance_type=t3.micro"
#2-priority - terraform.tfvars
#3-priority- anyfile  name contians auto
#4-defaults values
