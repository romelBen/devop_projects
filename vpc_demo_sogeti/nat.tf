# NAT Gateway
resource "aws_eip" "nat_gw_eip" {
  vpc = true
}
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = "${aws_eip.main-nat.id}"
  subnet_id = "${aws_subnet.public_subnet.id}"
}

# VPC setup for NAT
resource "aws_route_table" "vpc_us_east_main_nat" {
  vpc_id = "${aws_vpc.main.id}"

  route { 
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = "${aws_eip.nat_gw_eip.id}"
  }

  tags = {
      Name = "Main Route Table for NAT subnet"
  }
}

# Route Associations private
resource "aws_route_table_association" "main-private-1-a" {
  subnet_id = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.vpc_us_east_main_nat.id}"
}
