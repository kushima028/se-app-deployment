#!/bin/bash

# Refreshes package list (downloads latest versions)
sudo apt update -y

# Installs newest versions of packages we have
sudo apt upgrade -y

# Installs nginx web server
sudo apt install nginx -y

# Stop nginx process, then start it again
sudo systemctl restart nginx 

# Make nginx a startup process
sudo systemctl enable nginx