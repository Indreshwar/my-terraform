#creating a snapshot from the volume id present in console
resource "aws_ebs_snapshot" "Mysnap" {
  volume_id = "vol-0eeccaf57ce445df7"
  tags = {
    Name = "Own-snapshot"
  }

}
# Creating an AMI that will start a machine whose root device is backed by
# an EBS volume populated from a snapshot. We assume that such a snapshot
# already exists with the id "snap-xxxxxxxx".
resource "aws_ami" "terraform" {
  name                = "terraform-image"
  virtualization_type = "hvm"
  root_device_name    = "/dev/xvda"
  imds_support        = "v2.0"
  ebs_block_device {
    device_name = "/dev/xvda"
    snapshot_id = aws_ebs_snapshot.Mysnap.id
    volume_size = 8
  }

}



