resource "aws_elb" "elb-demo" {
  name = "terraform-asg-demo"
  security_groups = ["${aws_security_group.elb-sg.id}"]
  availability_zones = ["us-east-1a,us-east-1b,us-east-1c, us-east-1d, us-east-1e, us-east-1f"]
  health_check {
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 3
      interval = 10
      target = "HTTP:8080/"
  }
  listener {
      lb_port = 80
      lb_protocol = "http"
      instance_port = "8080"
      instance_protocol = "http"
  }

  tags = {
    Name = "Terraform-ELB"
  }
}