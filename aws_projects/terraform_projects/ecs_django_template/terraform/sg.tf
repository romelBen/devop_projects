### Bastion security group used for connecting to private instance
resource "aws_security_group" "bastion-sg" {
    name                = "bastion-sg"
    description         = "Allow SSH usage only"
    vpc_id              = data.aws_vpc.main.id

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        Name = "bastion-sg"
    }
}

### ALB Security Group for allowing HTTP and HTTPS connection from the internet
resource "aws_security_group" "alb-sg" {
    name                = "alb-sg"
    description         = "Allow Internet traffic in and out through ALB"
    vpc_id              = data.aws_vpc.main.id

    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        Name = "alb-sg"
    }
}

### Security group which has the ALB Security Group attached for
### port support for AWS ECS.
resource "aws_security_group" "ecs-sg" {
    name                = "ecs-sg"
    description         = "Allow SSH and Internet traffic through ALB"
    vpc_id              = data.aws_vpc.main.id

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        security_groups = [aws_security_group.bastion-sg.id]
    }

    ingress {
        from_port       = 32768
        to_port         = 65535
        protocol        = "tcp"
        security_groups = [aws_security_group.alb-sg.id]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        Name = "ecs-sg"
    }
}

# RDS Security Group for traffic ECS to arrive at our RDS
resource "aws_security_group" "rds-postgresql-sg" {
    name                = "rds-postgresql-security-group"
    description         = "Allows inbound access from ECS only"
    vpc_id              = data.aws_vpc.main.id

    ingress {
        from_port       = 5432
        to_port         = 5432
        protocol        = "tcp"
        security_groups = [aws_security_group.ecs-sg.id]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        Name = "rds-postgre-sg"
    }
}