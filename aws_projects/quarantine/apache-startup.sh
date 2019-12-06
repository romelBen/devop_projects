#!/bin/sh

# Update and install python and ansible into ec2 instance with nginx
#cd /tmp
#sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
#sudo systemctl start amazon-ssm-agent
#apt update
#apt install python-pip -y
#pip install ansible
#ansible-galaxy install nginxinc.nginx

# This is to install Nginx without Ansible
#amazon-linux-extras install -y nginx1.17.6

# This is to install Apache and create a file for testing
sudo yum update
sudo yum install -y httpd
sudo chkconfig httpd on
sudo service httpd start
echo "<h1>Hello this is Romel</h1>" | sudo tee /var/www/html/index.html