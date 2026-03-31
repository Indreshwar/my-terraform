#creating a default vpc its already present but terraform doesnot create the resource it add in state management
resource "aws_default_vpc" "default" {
  tags = {
    Name = "default-vpc"
  }

}

#Creating a security group and adding ingress and egrees is old method but we are following the smae here
resource "aws_security_group" "default-SG" {
  name        = "default-sg"
  description = "allow ssh access on port 22"
  vpc_id      = aws_default_vpc.default.id
  tags = {
    Name = "Default-SG"
  }
  #ingress will create an inbound rule for security group
  ingress {
    description = "allow ssh access to all traffic through port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #egress will create an outbound rule 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
#creating a key-pair
resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDuzrIyUAaxcB3cOJ44eYOORu4oTf7etFc7OfIjEeqgm6+ufV2Q+2BU6VOmoxfrPGDLB3i4V7NcGN+uQmPL4xuxGWntLd6MKUnxBNvlAR1hfMll8SX3F71I2ysI1mwWvKS7mVEH2PU/FbD/u8hgjqsf/01cA9w8OB+UeibZZG8SoxE/6DzYteaylAi0u5zuIzRUfD5GBx7pUiGxLTvoteY83ANvuIbZXoH5I7d8hT11JX55cwPpzErz5q8DyNcj1j79LP4SgxCvhGxjjbWjTSZ8aFK4WRiGOB0d+L8MA7dKEK4CJC1W75cCJrz2hCQ1EXiVrAAZaH7Zs0mgEyJSZ+5W5R+zYHpRErO9YPEtWkos5E2tvvTELi1X+bE2bdnsQ3HDuvJH3Y35PRXpJIDxfuzrtHfllfBIlmVTMcHJrnylqDGo7hVuCkSzySimRstnmU8443ZksBptS1RWlF9tMMs16UikhbcCS9eXKf5017S2Bpf9EW69ULUoOnZFtg9geOU= acer@DESKTOP-1CCKMED"

}

#Creating an ec2 instance and we cam login to ec2 instance using my key
resource "aws_instance" "myserver" {
  ami                    = "ami-05d2d839d4f73aafb"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.default-SG.id]
  key_name               = "mykey"
  tags = {
    Name = "mykeyserver"
  }
}


