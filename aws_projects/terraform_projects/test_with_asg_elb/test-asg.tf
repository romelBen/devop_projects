############ Web Configuration ###############
# Create Launch Configuration
resource "aws_launch_configuration" "web-launch-configuration" {
  name = "SQL Launch Configuration"
  image_id = "${lookup(var.AMIS-web, var.AWS_REGION)}"
  instance_type   = "t2.small"
  security_groups = ["${aws_security_group.sg-web.id}"]
  key_name        = "${var.AWS_KEY_NAME}"
  user_data       = "${file("install.sh")}"

  lifecycle {
    create_before_destroy = true
  }
}

# Create an Auto Scaling Group for the Web Server
resource "aws_autoscaling_group" "web-asg" {
  name = "SQL ASG"
  launch_configuration = "${aws_launch_configuration.web-launch-configuration.id}"
  min_size             = 1
  max_size             = 2
  desired_capacity     = 1
  health_check_type    = "ELB"
  load_balancers       = "$[aws_elb.elb-terraform.id]"
  vpc_zone_identifier  = "${aws_subnet.public_subnet.*.id}"
  tag {
    key                 = "Name"
    value               = "SQL-ASG-terraform"
    propagate_at_launch = true
  }
}



############ Microsoft SQL Server Configuariton ###############
# Create Launch Configuration
resource "aws_launch_configuration" "sqlserver-launch-setup" {
  name = "SQL Launch Configuration"
  image_id = "${lookup(var.AMIS-db, var.AWS_REGION)}"
  instance_type   = "t2.small"
  security_groups = ["${aws_security_group.sql-sg.id}"]
  key_name        = "${var.AWS_KEY_NAME}"

  lifecycle {
    create_before_destroy = true
  }
}

# Create an Auto Scaling Group for Microsoft SQL Server
resource "aws_autoscaling_group" "sqlserver-asg" {
  name = "SQL ASG"
  launch_configuration = "${aws_launch_configuration.sqlserver-launch-setup.id}"
  min_size             = 1
  max_size             = 2
  desired_capacity     = 1
  health_check_type    = "ELB"
  vpc_zone_identifier  = "${aws_subnet.private_subnet.*.id}"
  tag {
    key                 = "Name"
    value               = "SQL-ASG-terraform"
    propagate_at_launch = true
  }
}
