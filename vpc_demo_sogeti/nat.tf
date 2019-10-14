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


/*
# VPC setup for NAT
resource "aws_route_table" "private-nat" {
  vpc_id = "${aws_vpc.main.id}"

  route { 
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = "${aws_nat_gateway.nat-gw.id}"
  }

  tags = {
      Name = "Main Route Table for NAT subnet"
  }
}
*/
