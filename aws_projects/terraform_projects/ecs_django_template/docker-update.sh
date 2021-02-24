#!/bin/bash
## docker-update.sh

### Sign into ECR for Romel's Playground
aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 533989856255.dkr.ecr.us-east-1.amazonaws.com

# Build/Rebuild existing django-app and nginx image
sudo docker build -t 533989856255.dkr.ecr.us-east-1.amazonaws.com/django-app:latest .
sudo docker build -t 533989856255.dkr.ecr.us-east-1.amazonaws.com/nginx:latest .

# Push existing django-app and nginx image
sudo docker push 533989856255.dkr.ecr.us-east-1.amazonaws.com/django-app:latest
sudo docker push 533989856255.dkr.ecr.us-east-1.amazonaws.com/nginx:latest