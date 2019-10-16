# Define security group for public subnet
resource "aws_security_group" "sg-web" {
  vpc_id = "${aws_vpc.main.id}"
  name = "vpc_test_web"
  description = "Allow incoming HTTP connections & SSH access"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["64.132.0.202/32"]
  }

  ingress {
    from_port = 3389
    to_port = 3389
    protocol = "tcp"
    cidr_blocks = ["64.132.0.202/32"]
  }

  egress { # SQL Server access to db server
  from_port = 1433
  to_port = 1433
  protocol = "tcp"
  cidr_blocks = ["${var.private_subnet_cidr}"]
  }

  egress { # MySQL access to db server
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  cidr_blocks = ["${var.private_subnet_cidr}"]
  }

  tags = {
    Name = "Web Server SG"
  }
}

# Define the security group for the private subnet
resource "aws_security_group" "sg-db" {
  vpc_id = "${aws_vpc.main.id}"
  name = "sg_test_wb"
  description = "Allow traffic from public subnet"

  ingress { # SQL Server access from web servers
    from_port = 1433
    to_port = 1433
    protocol = "tcp"
    cidr_blocks = ["${aws_security_group.sg-web}"]
  }

  ingress { # MySQL access from the web servers
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  security_groups = ["${aws_security_group.sg-web.id}"]
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Database SG"
  }
}