############ Webserver instance configuariton ###############
# Create Launch Configuration
resource "aws_launch_configuration" "webserver-launch-setup" {
  name = "webserver launch setup"
  image_id = "${lookup(var.AMIS-web, var.AWS_REGION)}"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.sg-web.id}"]
  key_name        = "${var.AWS_KEY_NAME}"
  user_data       = "${file("apache-startup.sh")}"

  lifecycle {
    create_before_destroy = true
  }
}

# Create an Auto Scaling Group
resource "aws_autoscaling_group" "webserver-asg" {
  name = "webserver launch setup"
  launch_configuration = "${aws_launch_configuration.webserver-launch-setup.id}"
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  health_check_type    = "ELB"
  #load_balancers       = "$[aws_elb.elb-terraform.id]"
  vpc_zone_identifier  = "${aws_subnet.public_subnet.*.id}"
  tag {
    key                 = "Name"
    value               = "webserver-terraform"
    propagate_at_launch = true
  }
}

############# Windows 2012 instance configuration #################
# Create Launch Configuration
resource "aws_launch_configuration" "database-launch-setup" {
  name = "database launch config"
  image_id = "${lookup(var.AMIS-db, var.AWS_REGION)}"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.sg-db.id}"]
  key_name        = "${var.AWS_KEY_NAME}"

  lifecycle {
    create_before_destroy = true
  }
}

# Create an Auto Scaling Group
resource "aws_autoscaling_group" "database-asg" {
  name = "database launch setup"
  launch_configuration = "${aws_launch_configuration.database-launch-setup.id}"
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  health_check_type    = "ELB"
  #load_balancers       = "$[aws_elb.elb-terraform.id]"
  vpc_zone_identifier  = "${aws_subnet.private_subnet.*.id}"
  tag {
    key                 = "Name"
    value               = "database-terraform"
    propagate_at_launch = true
  }
}