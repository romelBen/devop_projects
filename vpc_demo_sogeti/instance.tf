# SSH key pair for our instances
resource "aws_key_pair" "testkey" {
  key_name = "testkey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "webserver" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public_subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.sg-web.id}"]
  associate_public_ip_address = true
  source_dest_check = false
  key_name = "${aws_key_pair.testkey.key_name}"
  user_data = "${file("install.sh")}"

  tags = {
    Name = "webserver"
  }
}

resource "aws_instance" "db" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.testkey.id}"
  subnet_id = "${aws_subnet.private_subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.sg-db.id}"]
  source_dest_check = false

  tags = {
    Name = "database"
  }
}
