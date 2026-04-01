#creating an ec2 instance
resource "aws_instance" "EIP-server" {
  ami           = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"
  tags = {
    Name = "EIP_server"
  }
}
#creating an Elastic Ip address
resource "aws_eip" "My-EIP" {
  #associating an EIP address to instance
  instance = aws_instance.EIP-server.id

}