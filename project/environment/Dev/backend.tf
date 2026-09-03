terraform {
  backend "s3" {
    bucket = "my-own-terraform-s3-bucket-2026"
    key    = "terraform/project/dev/vpc/terraform.tfstate"
    region = "ap-south-1"
  }
}