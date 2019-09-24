provider "aws" {}

resource "aws_instance" "my_Ubuntu" {
  count         = 0                       #создаеться 1 host
  ami           = "ami-0ac05733838eabc06" #тип os
  instance_type = "t2.micro"
  tags = {
    Name    = "My Amazon Server"
    Owner   = "Vitaliy Katkalo"
    Project = "Terraform Lessons"
  }
}
