resource "aws_cloudwatch_log_group" "django-log-group" {
    name = "/ecs/frontend-container"
    retention_in_days = var.log_retention_in_days

    tags = {
        Environment         = "dev"
        CreatedBy           = "romelben"
    }
}

resource "aws_cloudwatch_log_group" "nginx-log-group" {
    name = "/ecs/nginx"
    retention_in_days = var.log_retention_in_days

    tags = {
        Environment         = "dev"
        CreatedyBy          = "romelben"
    }
}