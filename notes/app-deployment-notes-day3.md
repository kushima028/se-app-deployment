# *Day 3 - Connecting Node.js Application to a Database*

## Overview

On Day 2 the application architecture was expanded by introducing a **separate database instance** and configuring **Nginx as a reverse proxy**.

The system now consists of two EC2 instances:

1. **Application Instance**
   - Runs the Node.js v20 application
   - Uses Nginx as a reverse proxy
2. **Database Instance**
   - Runs MongoDB v7
   - Stores application data

This separation follows common cloud architecture practices where **application logic and database services run on separate machines**.

---

# MongoDB Database Instance

## Instance Requirements

The database instance was configured with the following settings:

| Component | Value |
|---|---|
| OS | Ubuntu |
| Database | MongoDB v7 |
| Open Ports | 22 (SSH), 27017 (MongoDB) |

Security group inbound rules:

| Port | Purpose |
|---|---|
| 22 | SSH access |
| 27017 | MongoDB database access |

---

## Installing MongoDB v7

MongoDB v7 was installed using the official MongoDB repository.  
The installation steps followed the official MongoDB documentation:

https://www.mongodb.com/docs/v7.0/tutorial/install-mongodb-on-ubuntu/

The process was automated using the **`se-deploy-mongodb.sh` setup script**, which performs the installation and configuration automatically.

Key steps performed by the script include:

1. Updating system packages
2. Installing required dependencies
3. Adding the MongoDB GPG key and repository
4. Installing MongoDB v7 packages
5. Configuring bind IP value: By default, MongoDB only allows connections from **localhost**.To allow the application instance to connect, the MongoDB configuration file was modified.
    - navigate to the configuration directory: `cd /etc`
    - open config file: `sudo nano mongod.conf`
    - change bindIp: 127.0.0.1 to 0.0.0.0
    - restart mongod to use the new config
6. Make mongodb a startup process

# Node.js Application Instance

## Setup

The application instance setup was automated by using the **`se-deploy-node20-app-full-v2.sh` setup script**.

The Node.js application is run using **PM2**, which is a **process manager for Node.js applications**.

PM2 allows applications to:

- Run **in the background**
- Automatically **restart if they crash**
- Keep applications running **after SSH sessions close**
- Manage multiple Node.js processes

PM2 was installed globally on the application instance: `sudo npm install pm2@latest -g`

The application was then started (after navigating into the app directory) with: `pm2 start app.js`

### Reverse Proxy

#### What is a Reverse Proxy?

A **reverse proxy** sits between users and the backend application server.

It receives client requests and forwards them to the internal application service.

Benefits include:
- Improved **security** (application port hidden)
- **Cleaner URLs** without specifying ports
- Ability to add **load balancing, caching, or SSL later**

To set up reverse proxy:
1. go to /etc/nginx/sites-available/
2. open default:
    sudo nano default
3. inside location block remove `try_files $uri $uri/ =404;` and put `proxy_pass http://localhost:3000/;`
4. cd back to ~
5. sudo sytemctl restart nginx
6. check website (public IP), should work without :3000

## Connecting the app instance to the database instance

The Node.js application connects to MongoDB using an **environment variable**: `DB_HOST`.

Set an Environment Variable in the application instance
    - `export DB_HOST=mongodb://DB-INSTANCE-PUBLIC-IP:27017/posts`
    - `printenv DB_HOST` to test

### Seeding the DB

The database was populated with initial data using the seed script.
1. cd into app folder
2. stop running pm2 processes: `pm2 kill`
3. install dependencies listed in `package.json` by default: `sudo npm install`
4. run the seed script: `node seeds/seed.js`
5. restart the application: `pm2 start app.js`

The application data can then be accessed via: `http://APP-INSTANCE-PUBLIC-IP:3000/posts` or `http://APP-INSTANCE-PUBLIC-IP/posts` if a reverse proxy is implemented

