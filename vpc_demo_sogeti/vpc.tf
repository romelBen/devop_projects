# Internet VPC
resource "aws_vpc" "main" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"

    tags = {
        Name = "Demo VPC"
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
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1c"

  tags = {
      Name = "Database Private Subnet"
  }
}

# Internet GW
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
  tags = {
      Name = "VPC IGW"
  }
}

# Route Tables
resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.main.id}"

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
      Name = "Public Subnet RT"
  }
}

# Assign the route table to the public subnet
resource "aws_route_table_association" "web-public-rt" {
  subnet_id = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}