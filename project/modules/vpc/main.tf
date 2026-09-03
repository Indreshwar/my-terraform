#creating a vpc 
resource "aws_vpc" "project_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags ={
    Name = "${var.environment}-vpc"
    Environment = var.environment
  }
}

#creating a public subnet
resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.project_vpc.id
  cidr_block = var.subnet_cidr
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.environment}-publicSubnet-1"
    Environment = var.environment
  }
}

#creating an internet gateway
resource "aws_internet_gateway" "project_igw" {
  vpc_id = aws_vpc.project_vpc.id
  tags = {
    Name = "${var.environment}-igw"
    Environment = var.environment
  }
}

#create a Public Route table
resource "aws_route_table" "public_routeTable" {
  vpc_id = aws_vpc.project_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project_igw.id
  }
  tags =  {
    Name = "${var.environment}-Public-routeTable"
    Environment = var.environment
  }
}

#create route table association
resource "aws_route_table_association" "RT_association" {
  route_table_id = aws_route_table.public_routeTable.id
  subnet_id = aws_subnet.public_subnet_1.id
}
