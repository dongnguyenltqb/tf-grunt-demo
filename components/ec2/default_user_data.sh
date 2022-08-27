#!/bin/sh
sudo yum update -y
sudo yum groupinstall -y "Development Tools" "buildsys-build"
sudo amazon-linux-extras install docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -a -G docker ec2-user