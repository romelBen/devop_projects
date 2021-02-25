output "alb_dns" {
    value   = aws_alb.alb.dns_name
#   value   = module.alb.this_lb_dns_name
}

output "vpc_id" {
    value = module.vpc.vpc_id
}

output "public_subnets" {
    value = module.vpc.public_subnets
}

output "private_subnets" {
    value = module.vpc.private_subnets
}

output "igw_id" {
    value = module.vpc.igw_id
}