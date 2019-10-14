resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.main.id}"

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
      Name = "Public Subnet RT"
  }
}

resource "aws_default_route_table" "default-rt" {
  default_route_table_id = "${aws_vpc.main.default_route_table_id}"
}

# Assign public subnet to public route table 
resource "aws_route_table_association" "web-public-rt" {
  subnet_id = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}

# Assign privatge subnet to private route table
resource "aws_route_table_association" "db-private-rt" {
  subnet_id = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.web-public-rt}"
}
