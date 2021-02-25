data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name    = "name"
    values  = ["amzn-ami*amazon-ecs-optimized"]
  }

  filter {
    name    = "architecture"
    values  = ["x86_64"]
  }

  filter {
    name    = "virtualization-type"
    values  = ["hvm"]
  }
  owners  = ["amazon", "self"]
}

### Bastion launch configuration and ASG ###
resource "aws_launch_configuration" "bastion_lc" {
  name_prefix           = "bastion"
  image_id              = data.aws_ami.amazon_linux.id
  instance_type         = "t2.micro"
  key_name              = "prod-keypair"
  security_groups       = [aws_security_group.bastion-sg.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bastion-asg" {
  name                  = "bastion-asg"
  launch_configuration  = aws_launch_configuration.bastion_lc.name
  min_size              = 0
  desired_capacity      = 0
  max_size              = 1
  vpc_zone_identifier   = module.vpc.public_subnets

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                   = "Name"
    value                 = "Bastion Instance"
    propagate_at_launch   = true
  }
}

###### ECS launch configuration and ASG
## Creates a template of what the instance will need such as
## AMI, keypair, User Data, instance type, etc.
## Need to work on User Data for setting up URL.
resource "aws_launch_configuration" "lc" {
  name                        = "ecs-lc"
  iam_instance_profile        = aws_iam_instance_profile.ecs_service_role.name
  image_id                    = data.aws_ami.amazon_linux.id
  instance_type               = "t2.medium"
  key_name                    = var.key_name
  security_groups             = [aws_security_group.ecs-sg.id]
  associate_public_ip_address = true
  user_data                   = <<EOF
#! /bin/bash
sudo apt-get update
sudo echo "ECS_CLUSTER=${var.cluster_name}" >> /etc/ecs/ecs.config
EOF
  lifecycle {
    create_before_destroy = true
  }
}

## Creates the ASG to scale the instances with a Private instance.
resource "aws_autoscaling_group" "ecs-asg" {
  name                      = "ecs-asg"
  launch_configuration      = aws_launch_configuration.lc.name
  vpc_zone_identifier       = module.vpc.private_subnets
  min_size                  = 2
  desired_capacity          = 2
  max_size                  = 3
  health_check_type         = "EC2"
  health_check_grace_period = 60
  target_group_arns         = [aws_alb_target_group.alb-target-group.arn]
  protect_from_scale_in     = true

  lifecycle {
    create_before_destroy   = true
  }

  tag {
    key                     = "Name"
    value                   = "Prod"
    propagate_at_launch     = true
  }
}