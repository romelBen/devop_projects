# Looks through all zones in an AZ
data "aws_availability_zones" "available" {}

# Internet VPC
resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "Terraform VPC"
  }
}

# Internet GW
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"
  tags = {
    Name = "Terraform VPC IGW"
  }
}

# Elastic IP Address
resource "aws_eip" "elastic-ip" {
  vpc = true
}

# NAT Gateway
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = "${aws_eip.elastic-ip.id}"
  subnet_id = "${aws_subnet.public_subnet.id}"
  depends_on = ["${aws_internet_gateway.igw}"]
}

# Public Subnets
resource "aws_subnet" "public_subnet" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${element(var.public_subnet_cidr, count.index)}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "Webserver Subnet-${count.index + 1}"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${element(var.private_subnet_cidr, count.index)}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "Microsoft SQL Server Subnet-${count.index + 1}"
  }
}