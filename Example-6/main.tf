#creating a snapshot from the volume id present in console
resource "aws_ebs_snapshot" "MY-terraform-snap" {
  volume_id = "vol-0e48c28afd38f3641"
  tags = {
    Name = "terraform-snap"
  }
}


# Creating an AMI that will start a machine whose root device is backed by
# an EBS volume populated from a snapshot. We assume that such a snapshot
# already exists with the id "snap-xxxxxxxx".
resource "aws_ami" "terraform" {
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



