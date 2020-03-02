#!/bin/sh

# Install Java and set PATH
sudo yum install java-1.8*
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.161-0.b14.e17_4.x86_64/
# PATH = $PATH:$JAVA_HOME

# Download Jenkins on to the EC2 Instance
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io.redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

# Install and start Jenkins
sudo yum install jenkins
service jenkins start