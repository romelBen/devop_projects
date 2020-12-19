# DevOps Projects

## Terraform Projects (v0.11)
- (AWS) VPC architecture with a web server and database server with an ASG. I am able to create
 6 subnets but having issues with the NAT Gateway choosing the subnet. (Needs to be worked on)
- (AWS) Created a VPC architecture with 4 EC2 instances combined with an ASG that has Microsoft SQL Server installed. (Trying to find a way of scripting EBS volumes on all 4 instances if the instance is to fail.)
- (AWS) Created a VPC architecture with an EC2 instance combined with an ASG that has Jenkins and Docker installed.
- (AWS) S3 creation
- (Azure) Simple Web Architecture

#### Parameter file
#### This file will determine the region, vpc_cidr, public_subnet(s), private_subnet(s), and AMIs. (Remember, AMIs are different for every region.)
- var.tf

#### Important file to include in your project BUT must be removed from PUBLIC USE (use .gitignore)
##### This file will include your CONFIDENTIAL information. DO NOT allow this file to be put for the public because they will have programmatic access in your account which spells BAD.
- terraform.tfvars
```
AWS_ACCESS_KEY = "access key here"
AWS_SECRET_KEY = "secret key here"
AWS_KEY_PATH = "key path here" <here is an example: ~/.ssh/KeyTest.pem>
```

## CloudFormation Projects
- (AWS) Created a VPC architecture housing an EC2 instance
- (AWS) Created a VPC architecture with a EC2 instance (private instance), Load Balancer, and a Auto Scaling Group (for the Bastion Host when needed).

## Packer Projects
- Created Ubuntu 18.04 distro
- Created Ubuntu 20.04 distro

## Scripting Projects
- (Python) Email notification
- (Python) Information collector
- (Python) System monitor
- (Python) Display kernal and diskspace info

## Ansible Projects
- Script to install all necessary packages in Debian/Ubuntu distros
- Script to install Grafana + Prometheus + node_exporter (plugin) on a Raspberry Pi 4

## Currently working on:
- Working on Ansible scripts to setup Debian/Ubuntu servers with packages
- Also, working on an Ansible script that sets up a Raspberry Pi 4 with Grafana + Prometheus + node_exporter
(this plugin allows you to pull essential data from Linux servers such as CPU Utilization, Memory Utilization, Swap Usage,
etc.)

## Important
- I need to update from Terraform .11v to .12v/.13v so please bare with me on these changes since I would need to make sure the code works.