### This module supports AWS's S3 bucket use
# Please make sure you have the latest version to support your architecture
# https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest
module "s3-bucket" {
  source          = "terraform-aws-modules/s3-bucket/aws"
  version         = "1.17.0"

  bucket_prefix   = var.bucket_prefix
  acl             = "private"

  versioning = {
      enabled = var.versioning
  }

  tags = {
      Name        = "bevy project"
      Environment = "Dev"
  }
}

/*
resource "aws_s3_bucket_object" "object" {
  bucket          = var.bucket_prefix
  key             = "terraform.tfstate"
  source          = "terraform/state/"
}
*/