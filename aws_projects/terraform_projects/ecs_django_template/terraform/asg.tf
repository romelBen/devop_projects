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
  name_prefix           = "bevy-bastion"
  image_id              = data.aws_ami.amazon_linux.id
  instance_type         = "t2.micro"
  key_name              = "bevy-keypair"
  security_groups       = [aws_security_group.bastion-sg.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bastion-asg" {
  name                  = "bevy-bastion-asg"
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

###### Bevy ECS launch configuration and ASG
## Creates a template of what the instance will need such as
## AMI, keypair, User Data, instance type, etc.
## Need to work on User Data for setting up URL.
resource "aws_launch_configuration" "bevy_lc" {
  name                        = "bevy-ecs-lc"
  iam_instance_profile        = aws_iam_instance_profile.ecs_service_role.name
  image_id                    = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  security_groups             = [aws_security_group.bevy-sg.id] # CHANGED
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
resource "aws_autoscaling_group" "bevy-asg" {
  name                      = "bevy-asg"
  launch_configuration      = aws_launch_configuration.bevy_lc.name
  vpc_zone_identifier       = module.vpc.private_subnets # CHANGED
  min_size                  = 2
  desired_capacity          = 2
  max_size                  = 3
  health_check_type         = "ELB"
  health_check_grace_period = 60
  target_group_arns         = [aws_alb_target_group.bevy-alb-target-group.arn]
  protect_from_scale_in     = true

  lifecycle {
    create_before_destroy   = true
  }

  tag {
    key                     = "Name"
    value                   = "Bevy"
    propagate_at_launch     = true
  }
}