### This module supports AWS's S3 bucket use
# Please make sure you have the latest version to support your architecture
# https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest
module "s3-bucket" {
  source                          = "terraform-aws-modules/s3-bucket/aws"
  version                         = "1.18.0"

  bucket                          = var.bucket_prefix
  acl                             = "private"
  force_destroy                   = true # Only be used if you do NOT want your logs and where Terraform will not receive an error.
  attach_elb_log_delivery_policy  = true

  versioning = {
      enabled = var.versioning
  }

  tags = {
      Name        = "Prod project"
      Environment = "Dev"
  }
}