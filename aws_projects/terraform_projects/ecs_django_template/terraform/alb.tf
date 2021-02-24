### Bevy ALB is used for public hosting since is in a private instance for better security
## public instances will be used for a bastion host to connect to the private instance
resource "aws_alb" "bevy-alb" {
  name               = "bevy-alb"
  load_balancer_type = "application"
  internal           = false
  subnets            = module.vpc.public_subnets
  security_groups    = [aws_security_group.alb-sg.id]

  tags = {
    Environment = "bevy"
    CreatedBy   = "romelben"
  }
}

resource "aws_alb_target_group" "bevy-alb-target-group" {
  name                = "ECS-Bevy-Target-Group"
  port                = 80
  protocol            = "HTTP"
  vpc_id              = data.aws_vpc.main.id

  health_check {
    path                = var.health_check_path
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200"
  }
}

resource "aws_alb_listener" "bevy-alb-listener-secured" {
  load_balancer_arn   = aws_alb.bevy-alb.arn
  port                = "443"
  protocol            = "HTTPS"
  ssl_policy          = "ELBSecurityPolicy-2016-08"
  certificate_arn     = var.certificate_arn
  depends_on          = [aws_alb_target_group.bevy-alb-target-group]

  default_action {
    type              = "forward"
    target_group_arn  = aws_alb_target_group.bevy-alb-target-group.arn
  }
}

/*
resource "aws_alb_listener" "bevy-alb-listener" {
  load_balancer_arn   = aws_alb.bevy-alb.arn
  port                = "80"
  protocol            = "HTTP"

  default_action {
    type              = "forward"
    target_group_arn  = aws_alb_target_group.bevy-alb-target-group.arn
  }
}
*/

/*
module "alb" {
  source              = "terraform-aws-modules/alb/aws"
  version             = "5.10.0"

  name                = "bevy-alb"
  load_balancer_type  = "application"
  internal            = false
  vpc_id              = module.aws_vpc.main.id
  subnets             = module.vpc.public_subnets
  security_groups     = [aws_security_group.alb-sg.id]

  target_groups = [
    {
    name_prefix       = "ECS-Bevy-Target-Group"
    backend_protocol  = "HTTPS"
    backend_port      = 443
    target_type       = "instance"
    health_check = {
      path                = var.health_check_path
      healthy_threshold   = 2
      unhealthy_threshold = 10
      timeout             = 60
      interval            = 300
      matcher             = "200"
    }
    }
  ]

  http_tcp_listeners = [
    {
      port                = 80
      protocol            = "HTTP"
      action_type         = "redirect"
      target_group_index  = 0
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "200"
      }
    }
  ]
}
*/