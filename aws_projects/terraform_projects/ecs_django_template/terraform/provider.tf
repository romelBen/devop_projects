### The below information is contained in terraform.tfvars which must NOT be uploaded to the internet.
### It should ONLY be shared between Seniors and Administrators.
provider "aws" {
    region          = var.aws_region
    access_key      = var.access_key
    secret_key      = var.secret_key
}

/*
terraform {
    backend "s3" {
        bucket  = var.bucket_prefix
        key     = "state/terraform.tfstate"
        region  = "us-east-1"
    }
}
*/