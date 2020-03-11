# Define security group for public subnet
resource "aws_security_group" "sg-jenkins" {
  vpc_id = "${aws_vpc.main.id}"
  name = "Jenkins-SG"
  description = "Allow incoming HTTP connections & SSH access"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Jenkins Server SG"
  }
}

/*
# Define the security group for the private subnet
resource "aws_security_group" "sg-db" {
  vpc_id = "${aws_vpc.main.id}"
  name = "sg_test_db"
  description = "Allows incoming database connections"

  ingress { # SQL Server access from web servers
    from_port = 1433
    to_port = 1433
    protocol = "tcp"
    security_groups = ["${aws_security_group.sg-web.id}"]
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
*/