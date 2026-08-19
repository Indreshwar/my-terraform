#creates a snapshot of an EBS Volume

# Creating an AMI that will start a machine whose root device is backed by
# an EBS volume populated from a snapshot. We assume that such a snapshot
# already exists with the id "snap-xxxxxxxx"

resource "aws_ami" "terraform-AMI" {
  name                = "terraform-image"
  virtualization_type = "hvm"
  root_device_name    = "/dev/sda1"
  imds_support        = "v2.0"
  ebs_block_device {
    device_name = "/dev/sda1"
    snapshot_id = "snap-04ed5889213e3ebd2"
    volume_size = 30
  }
}
#copyingAMI from one region to another region
resource "aws_ami_copy" "example" {
  provider          = aws.destination
  name              = "terraform-example"
  source_ami_id     = aws_ami.terraform-AMI.id
  source_ami_region = "ap-south-1"

  tags = {
    Name = "HelloWorld"
  }
}



