#!/bin/sh
yum install -y httpd
service start httpd
chkconfig httpd on
echo "<html><h1>Hello from Romel!</h1></html>" > /var/www/html/index.html