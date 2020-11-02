#!/bin/bash
sudo su
yum -y install httpd
echo "<p> My Instance $(hostname -f) </p>" >> /var/www/html/index.html
sudo systemctl enable httpd
sudo systemctl start httpd