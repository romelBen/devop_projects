resource "aws_instance" "webserver" {
  count = 1
  ami = "${lookup(var.AMIS-web, var.AWS_REGION)}"
  instance_type = "t2.micro"
  subnet_id = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.sg-web.id}"]
  associate_public_ip_address = true
  source_dest_check = false
  key_name = "${var.AWS_KEY_NAME}"

  tags = {
    Name = "Webserver"
  }
}

resource "aws_instance" "jenkins" {
  count = 1
  ami = "${lookup(var.AMIS-db, var.AWS_REGION)}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.sg-db.id}"]
  subnet_id = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  key_name = "${var.AWS_KEY_NAME}"
  source_dest_check = false

  tags = {
    Name = "Jenkins Server"
  }
}
