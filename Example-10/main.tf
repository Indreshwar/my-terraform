#creating a vpc
resource "aws_vpc" "my-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true #enables DNS resolution which resolves doman names to IP
  enable_dns_hostnames = true #assign DNS hostnames to ec2 instances
  tags = {
    Name = "My-vpc"
  }
}
#creating an internet gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-igw"
  }

}
#creating an public subnet-1
resource "aws_subnet" "public-1" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true #indicates the instances launched in this subnet public ip will get assigned
  availability_zone       = "ap-south-1a"
  tags = {
    Name = "Public-subnet-1"
  }

}
#creating a public subnet-2
resource "aws_subnet" "public-2" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true #indicates the instance launched in this subnet public ip will get assigned
  availability_zone       = "ap-south-1b"
  tags = {
    Name = "Public-subnet-2"
  }
}

#creating a route table
resource "aws_route_table" "my-RT" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
  tags = {
    Name = "my-routetable"
  }
}

#associating the public subnet-1 with my route table
resource "aws_route_table_association" "subnet-1" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.my-RT.id

}

#associating the public subnet-2 with my rute table
resource "aws_route_table_association" "subnet-2" {
  subnet_id      = aws_subnet.public-2.id
  route_table_id = aws_route_table.my-RT.id
}

#creating a ec2 instance in public subnet-1
resource "aws_instance" "server-1" {
  ami           = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"
  key_name      = "terraform key"
  subnet_id     = aws_subnet.public-1.id
  tags = {
    Name = "Public-server-1"
  }


}

