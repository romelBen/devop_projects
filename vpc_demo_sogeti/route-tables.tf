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

# Default route table
resource "aws_default_route_table" "default-route-table" {
  default_route_table_id = "${aws_vpc.main.id}"
}


# Assign public subnet to public route table
resource "aws_route_table_association" "web-public-rt" {
  subnet_id = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_vpc}"
}

# Route Associations private
resource "aws_route_table_association" "default-route" {
  subnet_id = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_eip.nat_gw_eip.id}"
}
