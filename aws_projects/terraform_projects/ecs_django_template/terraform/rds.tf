# RDS DB instances using PostgreSQL
module "rds" {
  source        = "terraform-aws-modules/rds/aws"
  version       = "2.20.0"

  identifier                = "postgresql-db-master"
  name                      = var.rds_db_name
  username                  = var.rds_username
  password                  = var.rds_password
  port                      = "5432"
  engine                    = "postgres"
  engine_version            = "12.5"
  major_engine_version      = "12"
  instance_class            = var.rds_instance_class
  allocated_storage         = "20"
  storage_encrypted         = false
  vpc_security_group_ids    = [aws_security_group.rds-postgresql-sg.id]
  subnet_ids                = module.vpc.private_subnets
  multi_az                  = false
  storage_type              = "gp2"
  publicly_accessible       = false
  backup_retention_period   = 7
  skip_final_snapshot       = true
  maintenance_window        = "Mon:00:00-Mon:03:00"
  backup_window             = "03:00-06:00"
  create_db_parameter_group = false
  parameter_group_name      = "default.postgres12"
}