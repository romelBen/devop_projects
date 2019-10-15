resource "aws_instance" "webserver" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public_subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.sg-web.id}"]
  associate_public_ip_address = true
  source_dest_check = false
  key_name = "${var.AWS_KEY_NAME}"
#  user_data = "${file("install.sh")}"

  tags = {
    Name = "webserver"
  }
}

resource "aws_instance" "db" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${var.AWS_KEY_NAME}"
  vpc_security_group_ids = ["${aws_security_group.sg-db.id}"]
  subnet_id = "${aws_subnet.private_subnet.id}"
  source_dest_check = false

  tags = {
    Name = "database"
  }
}
