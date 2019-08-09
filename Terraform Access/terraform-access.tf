provider "aws" {
  access_key = "access_key_here"
  secret_key = "secret_key_here"
  region = "us-east-1"
}

resource "aws-isntance" "example" {
  # AWS Linux distro
  ami = "ami-0b898040803850657"
  instance_type = "t2.micro"
}

