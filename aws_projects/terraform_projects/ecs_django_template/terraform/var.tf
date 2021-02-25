variable "access_key" {}
variable "secret_key" {}
variable "aws_region" {}

# Here is the name of your ssh key where it will be built
variable "key_name" {
  type          = string
  description   = "The name for your ssh key for usage towards your aws_launch_configuration."
}

# Here is the creation of the ECS Cluster name
variable "cluster_name" {
  type          = string
  description   = "The name of the AWS ECS Cluster"
}

######## These are your RDS variables ########
variable "rds_db_name" {
  description   = "RDS database name"
  default       = "postgresqldb"
}

variable "rds_username" {
  description   = "RDS database username"
  default       = "rubynube"
}

variable "rds_password" {
  description   = "RDS database password"
}

variable "rds_instance_class" {
  description   = "RDS instance type"
  default       = "db.t2.micro"
}

######## These are your S3 variables #########
# This will be the unique bucket name for access logs
variable "bucket_prefix" {
  type          = string
  description   = "Creates a unqiue bucket name beginning with the specified prefix"
  default       = "ruby-access-logs"
}

# This is if you want to enable versioning on the bucket.
variable "versioning" {
  type          = bool
  description   = "A state of versioning."
  default       = true
}

########## AWS ACM certificate Manager variables ##########
variable "certificate_arn" {
  description = "AWS Certificate Manager ARN for validated domains"
  default     = "arn:aws:acm:us-east-1:533989856255:certificate/c7bea500-ee08-452b-b982-9278961cd8a7"
}

########### CloudWatch Logs Variables #######
variable "log_retention_in_days" {
  default     = 30
}

######### Load Balancer variables #########
variable "health_check_path" {
  description = "Health check path for the default target group"
  default     = "/ping/"
}

######### Docker route variables for ECS Cluster ##########
variable "django_docker_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "533989856255.dkr.ecr.us-east-1.amazonaws.com/django-app:latest"
}

variable "ngnix_docker_image" {
  description = "Nginx Docker image for our ECS Cluster"
  default     = "533989856255.dkr.ecr.us-east-1.amazonaws.com/nginx:latest"
}

####### Input URL of ALLOWED_HOSTS in Django's settings ############
variable "allowed_hosts" {
  description = "Domain name for allowed hosts"
  default     = ".rubynube.org"
}