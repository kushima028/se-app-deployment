#!/bin/bash

# Refreshes package list (downloads latest versions)
sudo apt update -y

# Installs newest versions of packages we have
sudo apt upgrade -y

# install gnupg and curl
sudo apt install gnupg curl

# Get GPG key for mongodb 7
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor

# Add to sources list file
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# update again to download mongo v7
sudo apt update -y

# install mongodb components
sudo apt-get install -y \
   mongodb-org=7.0.24 \
   mongodb-org-database=7.0.24 \
   mongodb-org-server=7.0.24 \
   mongodb-mongosh \
   mongodb-org-shell=7.0.24 \
   mongodb-org-mongos=7.0.24 \
   mongodb-org-tools=7.0.24 \
   mongodb-org-database-tools-extra=7.0.24

# install sed
sudo apt install sed -y

# configure bind IP value
sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf

# strat mongodb
# changed from start to restart, check if it works now!
sudo systemctl restart mongod

# enable mongod -> makes mongodb a startup process
sudo systemctl enable mongod