variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_KEY_PATH" {}
variable "AWS_KEY_NAME" {}
variable "AWS_REGION" {
    default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "AMIS-web" {
    type = "map"
    default = {
        # AMI is Ubuntu
        us-east-1 = "ami-0b25b3d814fa986ce"
    }
}

variable "AMIS-db" {
  type = "map"
  default = {
    us-east-1 = "ami-04065317647cd68fc"
  }
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}