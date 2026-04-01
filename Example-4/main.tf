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
  content  = "Hello welcome to terrform"
  filename = "hello.txt"

}

resource "local_file" "file1" {
  content  = "he path to the file that will be created. Missing parent directories will be created. If the file already exists, it will be overridden with the given content."
  filename = "samplefile.txt"

}