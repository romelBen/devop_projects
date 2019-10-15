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
