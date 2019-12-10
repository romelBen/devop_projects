# Internet VPC
resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "Terraform VPC"
  }
}

# NAT Gateway
resource "aws_eip" "nat_gw_eip" {
  vpc = true
  depends_on = ["aws_internet_gateway.igw"]
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = "${aws_eip.nat_gw_eip.id}"
  subnet_id = "${aws_subnet.public_subnet.id}"

  tags = {
    Name = "NAT Gateway"
  }
}

# Internet GW
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"
  tags = {
    Name = "Terraform VPC IGW"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnet" {
  #count = "${length(var.public_subnet_cidr)}"
  vpc_id = "${aws_vpc.main.id}"
  #cidr_block = "${element(var.public_subnet_cidr, count.index)}"
  cidr_block = "${var.public_subnet_cidr}"
  #availability_zone = "${element(var.azs, count.index)}"
  availability_zone       = "${var.azs}"
  map_public_ip_on_launch = true
  tags = {
    #Name = "Webserver Subnet-${count.index + 1}"
    Name = "Webserver Subnet"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet" {
  #count = "${length(var.private_subnet_cidr)}"
  vpc_id = "${aws_vpc.main.id}"
  #cidr_block = "${element(var.private_subnet_cidr, count.index)}"
  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "${var.azs}"
  #availability_zone = "${element(var.azs, count.index)}"
  tags = {
    #Name = "Database Subnet-${count.index + 1}"
    Name = "Database Subnet"
  }
}

