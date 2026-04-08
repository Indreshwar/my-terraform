#in our linux os there is algorithm,which is called rand-> will generate the random number which is combination of string and number
#ex-ab12333&4354!%
resource "random_string" "random" {
  length  = 16
  special = false
  upper   = false
  count   = 3
}

#create a s3 bucket with the random names
resource "aws_s3_bucket" "my-bucket" {
  bucket = "terraform.${random_string.random[count.index].id}"
  count  = 3
  tags = {
    Name = "MYbucket-${count.index}"
  }

}