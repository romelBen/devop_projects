variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_KEY_PATH" {
}

variable "AWS_KEY_NAME" {
}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "azs" {
  default = "us-east-1a"
}

variable "AMIS-jenkins" {
  type = "map"
  default = {
    us-east-1 = "ami-0a887e401f7654935" # AWS Linux 2 AMI
  }
}
