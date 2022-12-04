#!/bin/bash
sudo su
yum update -y
amazon-linux-extras install -y java-openjdk11
yum install -y unzip
yum install -y docker
yum install -y python3-pip
pip3 install docker-compose
usermod -a -G docker ec2-user
id ec2-user
newgrp docker
systemctl enable docker.service
systemctl start docker.service