source "amazon-ebs" "ami-gold" {
    region          = var.vpc_region
    access_key      = var.aws_access_key
    secret_key      = var.aws_secret_key
    ssh_username    = var.ssh_username
    instance_type   = var.instance_type
    ami_name        = "gold-ami-ubuntu-18.04-{{isotime | clean_resource_name}}"
    associate_public_ip_address = true

    vpc_filter
        filters = {
            "tag:Name": "TestVPC"
            "isDefault": "false"
        }

    subnet_filter {
        filters = {
            "tag:Name": "TestSubnet"
        }
    }

    security_group_filter {
        filters = {
            "tag:Name": "TestSG"
        }
    }

    source_ami_filter {
        filters = {
            virtualization-type = "hvm"
            name = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
            root-device-type = "ebs"
        }
        owners = ["679593333241"]
        most_recent = true
    }
}