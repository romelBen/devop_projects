# Infrastructure Projects (Terraform/CloudFormation)

## Terraform projects include...
- (AWS) VPC architecture with a web server and database server with an ASG. I am able to create
 6 subnets but having issues with the NAT Gateway choosing the subnet. (Needs to be worked on)
- (AWS) Created a VPC architecture with 4 EC2 instances combined with an ASG that has Microsoft SQL Server installed. (Trying to find a way of scripting EBS volumes on all 4 instances if the instance is to fail.) 
- (AWS) Created a VPC architecture with an EC2 instance combined with an ASG that has Jenkins and Docker installed.
- (AWS) S3 creation
- (Azure) Simple Web Architecture

#### Important file to include AND remove from PUBLIC (use .gitignore)
- terraform.tfvars (This file will include your CONFIDENTIAL information. DO NOT allow this file to be put 
for the public because they will have programmatic access in your account which spells BAD.)
```
AWS_ACCESS_KEY = "access key here"
AWS_SECRET_KEY = "secret key here"
AWS_KEY_PATH = "key path here" <here is an example: ~/.ssh/KeyTest.pem>
```

## CloudFormation projects include...
- (AWS) Created a VPC architecture housing an EC2 instance
- (AWS) Created a VPC architecture with a EC2 instance (private instance), Load Balancer, and a Bastion Host (public instance).

#### Note
All my projects use YAML since JSON has given me many difficulties when it comes to error or format.

## Scripting projects include...
- (Python) Email notification
- (Python) Information collector
- (Python) System monitor
- (Python) Display kernal and dispace info

## Soon to come:
- (AWS) EKS sample architecture (needs to be worked on)
