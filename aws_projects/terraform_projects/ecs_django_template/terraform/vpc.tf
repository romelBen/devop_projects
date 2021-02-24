### This module supports AWS's VPC architecture with 6 AZs and 6 Public Subnets
# Please make sure you have the latest version to support your architecture
# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "vpc" {
    source                  = "terraform-aws-modules/vpc/aws"
    version                 = "2.70.0"
    name                    = "ecs_provisioning"
    cidr                    = "10.0.0.0/16"
    azs                     = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
    public_subnets          = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
    private_subnets         = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]

    enable_nat_gateway      = true
    single_nat_gateway      = true
    one_nat_gateway_per_az  = false


    tags = {
        Terraform   = "true"
        Environment = "romelben"
    }
}

data "aws_vpc" "main" {
    id = module.vpc.vpc_id
}