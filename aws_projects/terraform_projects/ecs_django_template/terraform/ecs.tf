resource "aws_ecs_cluster" "web-cluster" {
    name                    = var.cluster_name
    capacity_providers      = [aws_ecs_capacity_provider.ecs-web.name]
    tags    = {
        Environment      = "dev"
        CreatedBy        = "romelben"
    }
}

resource "aws_ecs_capacity_provider" "ecs-web" {
    name                    = "bevy-capacity-provider"
    auto_scaling_group_provider {
        auto_scaling_group_arn          = aws_autoscaling_group.bevy-asg.arn
        managed_termination_protection  = "ENABLED"

        managed_scaling {
            status          = "ENABLED"
            target_capacity = 85
        }
    }
}

### Here lies the container-definition.json file to input what each container's parameters
### must have.
data "template_file" "ecs-containers" {
    template = file("container-definitions/container-def.json")

    vars = {
        django_docker_image = var.django_docker_image
        ngnix_docker_image  = var.ngnix_docker_image
        rds_db_name         = var.rds_db_name
        rds_username        = var.rds_username
        rds_password        = var.rds_password
        allowed_hosts       = var.allowed_hosts
    }
}

# Update file container-def so it's pulling images from ECR
resource "aws_ecs_task_definition" "ecs-task-definition" {
    family                  = "django-app"
    container_definitions   = data.template_file.ecs-containers.rendered
    network_mode            = "bridge"
    depends_on              = [module.rds]

    volume {
        name        = "static_volume"
        host_path   = "/usr/src/app/staticfiles/"
    }
}

resource "aws_ecs_service" "service" {
    name                    = "bevy-web-service"
    cluster                 = aws_ecs_cluster.web-cluster.id
    task_definition         = aws_ecs_task_definition.ecs-task-definition.arn
    depends_on              = [aws_alb_listener.bevy-alb-listener-secured]
    desired_count           = 4

    ordered_placement_strategy {
        type    = "binpack"
        field   = "cpu"
    }

    load_balancer {
        target_group_arn    = aws_alb_target_group.bevy-alb-target-group.arn
        container_name      = "nginx"
        container_port      = 80
    }
    # Optional: Allow external changes without Terraform plan difference (for example ASG)
    lifecycle {
        ignore_changes = [desired_count]
    }
}