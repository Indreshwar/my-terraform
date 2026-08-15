resource "aws_vpc" "my-vpc" {
cidr_block = var.vpc_cidr
enable_dns_hostnames = true
enable_dns_support = true
  tags ={
    Name = "${var.environment}-vpc"
    Environment = var.environment
  }
}

#create an internet gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "${var.environment}-igw"
    Environment = var.environment
  }
}

#create a public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.my-vpc.id
  availability_zone = var.availability_zone
  cidr_block = var.subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.environment}-publicSubnet"
    Environment = var.environment
  }
}

#create a route table
resource "aws_route_table" "my-RT" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
   }
   tags ={
     Name = "${var.environment}-RT"
   }
}

#create route table asscoiation
resource "aws_route_table_association" "my-RT-asscoiation" {
  subnet_id = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.my-RT.id
}
