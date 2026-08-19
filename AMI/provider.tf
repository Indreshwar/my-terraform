terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.58.0"
    }
  }
}

# Source region
provider "aws" {
  region = "ap-south-1"
}

# Destination region
provider "aws" {
  alias  = "destination"
  region = "us-east-1"
}