# Internet VPC
resource "aws_vpc" "main" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"

    tags = {
        Name = "Demo VPC"
    }
}

# Internet GW
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"
  tags = {
      Name = "VPC IGW"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnet" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "us-east-1a"

  tags = {
      Name = "Web Public Subnet"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "us-east-1c"

  tags = {
      Name = "Database Private Subnet"
  }
}
