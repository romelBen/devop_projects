#!/bin/bash

# Full update of RHEL 8 distro
sudo yum -y update

# Install python3 and pip
sudo yum install python3 -y
# This is optional. This will name python 3 to python
yum -y install python3-pip
alternatives --set python /usr/bin/python3 

# Create a new user and password for the user
useradd ansadmin
passwd ansadmin

# Add ansadmin to the sudoers file
echo "ansadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# sed command will replace PasswordAuthentication no to yes
sed -ie 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/ssh_config
sudo service ssh reload

# Swtich to ansadmin to install Ansible
su - ansadmin
pip3 install ansible --user

# Create a directory for ansible
sudo mkdir /etc/ansible
cd /etc/ansible/

