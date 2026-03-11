#!/bin/bash

echo "========= SETUP ========="
# Refreshes package list (downloads latest versions)
sudo apt update -y

# Installs newest versions of packages we have
sudo apt upgrade -y

## Nginx
echo "========= NGINX ========="
# Installs nginx web server
sudo apt install nginx -y

# Stop nginx process, then start it again
sudo systemctl restart nginx 

# Make nginx a startup process
sudo systemctl enable nginx

echo "========= GITHUB PULL ========="
## Pull from GitHub
git clone https://github.com/kushima028/nodejs20-se-test-app-2025

echo "========= NODEJS V20.X ========="
## Install nodejs v20.x
sudo bash -c "curl -fsSL https://deb.nodesource.com/setup_20.x | bash -"
sudo apt install nodejs -y

## Deploy app
cd nodejs20-se-test-app-2025
cd nodejs20-se-test-app-2025
cd app

echo "========= INSTALL PACKAGES ========="
sudo npm install
# install pm2 to run app in background
echo "========= INSTALL PM2 ========="
sudo npm install pm2@latest -g

# Kill any node processes
pm2 kill

pm2 start app.js