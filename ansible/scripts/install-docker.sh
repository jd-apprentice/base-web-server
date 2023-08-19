#!/bin/bash

## Install Docker on Amazon Linux
sudo dnf update -y
sudo dnf list | grep docker
sudo dnf install -y docker
sudo systemctl start docker.service
sudo systemctl enable docker