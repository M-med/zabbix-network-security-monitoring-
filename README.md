# 🛡️ Zabbix Network Security Monitoring

![Zabbix](https://img.shields.io/badge/Zabbix-7.0-red)
![Ubuntu](https://img.shields.io/badge/Ubuntu-24.04-orange)
![Windows](https://img.shields.io/badge/Windows-10-blue)
![License](https://img.shields.io/badge/License-MIT-green)

-------- 

## 📖 Description

This project outlines the implementation of a **network security monitoring and supervision** solution based on **Zabbix 7**, deployed on **Ubuntu Server 24.04** with agents running on **Windows 10** and **Linux**.

The aim is to monitor the availability, performance and security alerts of machines on a network in real time, in order to proactively detect incidents and ensure the resilience of the infrastructure.

---------

## 🎯 Project objectives

- Deploy a Zabbix server on Ubuntu Server 24.04
- Configure the Zabbix web interface
- Install and configure Zabbix agents (Windows & Linux)
- Monitor availability and security alerts
- Set up dashboards and custom alerts
- Document the entire installation and configuration process

----------

## 🛠️ Technologies used


-  **Ubuntu Server** 24.04 LTS : Server operating system 
-  **Zabbix** 7.0 : Monitoring platform 
-  **Apache** 2.4.58 : Web server for the Zabbix interface 
-  **MySQL** 8.0.45 : Zabbix database 
-  **PHP** 8.x : Language for the web interface 
-  **Windows 10** : Monitored client 
-  **Ubuntu PC** : Monitored client 

-----------

## 📋 Prerequisites

### Zabbix Server (Ubuntu 24.04)
- Root or sudo access
- Internet connection
- Minimum 2 GB RAM (4 GB recommended)
- 20 GB disk space

### Clients
- Windows 10 with administrator access
- Ubuntu with sudo access
- Network connectivity to the Zabbix server

---------

## 🚀 Quick installation

### 1️⃣ Installing the Zabbix server

## Update the system
sudo apt update && sudo apt upgrade -y

## Install dependencies
sudo apt install -y apache2 mysql-server php php-mysql php-gd php-bcmath php-net-socket php-gettext

## Add the Zabbix repository
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-1+ubuntu24.04_all.deb
sudo dpkg -i zabbix-release_7.0-1+ubuntu24.04_all.deb
sudo apt update

## Install Zabbix Server, Frontend and Agent
sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent

## Create the database
sudo mysql -e ‘CREATE DATABASE zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;’
sudo mysql -e ‘CREATE USER “zabbix”@'localhost' IDENTIFIED BY “password”;’
sudo mysql -e ‘GRANT ALL PRIVILEGES ON zabbix.* TO “zabbix”@'localhost';’
sudo mysql -e ‘SET GLOBAL log_bin_trust_function_creators = 1;’

## Import the initial schema
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix

## Configure the Zabbix Server
sudo nano /etc/zabbix/zabbix_server.conf
## Change: DBPassword=password

## Start the services
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2

---------

### 2️⃣ Accessing the web interface

## Open a web browser and go to:
http://yourIPaddress/zabbix

## Default credentials:
- Username: Admin
- Password: zabbix

---------

### 3️⃣ Installing the Zabbix Agent on Windows

1 - Download the Zabbix Agent 7.4.7 installer
2 - Run the installation
3 - Configure:
    - Host name: DESKTOP-XXXXX
    - Zabbix server IP/DNS: 192.168.1.14
    - Agent listen port: 10050
    - Server or Proxy for active checks: 127.0.0.1
4 - Complete the installation and start the service

----------

### 4️⃣ Installing the Zabbix agent on Ubuntu
sudo apt install -y zabbix-agent
sudo systemctl start zabbix-agent
sudo systemctl enable zabbix-agent

---------

### 📊 Monitoring and alerts

## Configured dashboards
- Global View: Overview of all hosts
- Problems: List of active issues by severity
- Host Availability: Host availability
- CPU Utilisation: CPU utilisation per host

----------

### 📸 Screenshots

## Zabbix Dashboard
https://screenshots/dashboard.png

## Detected issues
https://screenshots/problems.png

## Host configuration
https://screenshots/host_config.png

---------

### 📚 Documentation
## The full documentation is available in the folder docs/ :
01 - Introduction
02 - Architecture
03 - Installation
04 - Configuration
05 - Supervision
06 - Dépannage

---------

### 🔧 Available scripts

- **install_zabbix_server.sh** : Automated installation of the Zabbix server
- **install_zabbix_agent_ubuntu.sh** : Installation of the agent on Ubuntu
- **install_zabbix_agent_windows.ps1** : Installation of the agent on Windows
- **backup_zabbix_db.sh** : Backing up the Zabbix database

----------

# 📁 Zabbix Templates

This folder contains Zabbix XML templates for monitoring security on Windows, Linux, and network devices.

## 📄 Available Templates

- `template_windows_security.xml`: Windows Security Monitoring (services, events, disk, CPU, memory) 
- `template_linux_security.xml` : Linux Security Monitoring (services, logs, disk, CPU, memory) 
- `template_network_security.xml` : Network Security Monitoring (SNMP, interfaces, traffic, uptime) 

## 🔧 How to Import Templates

### Method 1: Zabbix Web Interface

1. Log in to the Zabbix frontend.
2. Navigate to **Configuration → Templates**.
3. Click the **Import** button (top right).
4. Select the XML file to import.
5. Click **Import**.

### Method 2: Zabbix CLI (optional)

```bash
# Using zabbix-cli (if installed)
zabbix-cli --import-template templates/template_windows_security.xml

----------

### 📄 License

This project is licensed under the MIT licence. See the LICENSE file for further details.
