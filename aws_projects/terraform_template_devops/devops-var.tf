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
    us-east-1 = "ami-0c322300a1dd5dc79" # AMI of RedHat Linux
  }
}

/*
variable "private_subnet_cidr" {
  default = "10.0.5.0/24"
}

variable "azs" {
  type    = "list"
  default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
}

variable "AMIS-db" {
  type = "map"
  default = {
    us-east-1 = "ami-055c10ae78f3a58a2" # SQL server 2012
    
  }
}
*/
