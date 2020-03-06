#!/bin/bash
sudo yum -y update

# Installation of Java JDK 8
echo "Install Java JDK 8"
sudo yum remove -y java
sudo yum install -y java-1.8.0-openjdk

# Installation of git
echo "Install git"
sudo yum -y git

# Installation of Docker engine
echo "Install Docker engine"
yum update -yum
yum install docker -yum
sudo chkconfig docker on

# Insallation of Jenkins
echo "Install Jenkins"
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum install -y jenkins
sudo usermod -a -G docker jenkins
sudo chkconfig jenkins on

# Start Docker and Jenkins
sudo service docker start
sudo service jenkins start