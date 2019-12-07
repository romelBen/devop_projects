resource "aws_launch_configuration" "launch-setup" {
    name = "terraform-asg"
    image_id = "${lookup(var.AMIS-web, var.AWS_REGION)}"
    instance_type = "t2.micro"
    security_groups = ["${aws_security_group.sg-web.id}"]
    key_name = "${var.AWS_KEY_NAME}"
    user_data = "${file("install.sh")}"

    lifecycle {
      create_before_destroy = true
    }
}

# Create an Auto Scaling Group
resource "aws_autoscaling_group" "asg-demo" {
  name = "ASG-terraform"
  launch_configuration = "${aws_launch_configuration.launch-setup.id}"
  min_size = 1
  max_size = 3
  desired_capacity = 1
  health_check_type = "ELB"
  load_balancers = ["${aws_elb.elb-terraform.id}"]
  vpc_zone_identifier = "${aws_subnet.public_subnet.*.id}"
  tag {
      key = "Name"
      value = "terraform-asg-demo"
      propagate_at_launch = true
  }
}