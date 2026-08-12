#creating a local file in our system
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.6.1"
    }
  }
}

resource "local_file" "demo" {
  content  = "hello ,welcome to terraform practice"
  filename = "hello.txt"
}

resource "local_file" "file1" {
  content  = "if the file exist and if we change the content and do the terraform apply it will first delete the file and create the file with the new content"
  filename = "sample-file.txt"
}
