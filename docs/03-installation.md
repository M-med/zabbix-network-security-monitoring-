# 03 - Installation

This guide provides step-by-step instructions for installing and configuring the Zabbix monitoring solution.

## 📋 Prerequisites

### Hardware Requirements
- **Zabbix Server**: 2 CPU cores, 4 GB RAM, 50 GB disk
- **Monitored Hosts**: Minimal resources (agent only)

### Software Requirements
- Ubuntu Server 24.04 LTS (clean installation)
- Internet access
- Root or sudo privileges

### Network Requirements
- Static IP: `192.168.1.14`
- Open ports: 80, 443, 10050, 10051

--------

## 🚀 Step 1: Prepare Ubuntu Server

### 1.1 Update the System
sudo apt update && sudo apt upgrade -y

### 1.2 Set Hostname
sudo hostnamectl set-hostname zabbix-server

## 🚀 Step 2: Install MySQL

###  2.1 Install MySQL Server
sudo apt install -y mysql-server

### 2.2 Secure MySQL
sudo mysql_secure_installation

### 2.3 Create Zabbix Database
sudo mysql -u root -p
CREATE DATABASE zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'zabbix_password';
GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';
SET GLOBAL log_bin_trust_function_creators = 1;
FLUSH PRIVILEGES;
EXIT;

## 🌐 Step 3: Install Apache and PHP

### 3.1 Install Apache
sudo apt install -y apache2

### 3.2 Install PHP and Extensions
sudo apt install -y php php-mysql php-gd php-bcmath php-net-socket php-gettext php-xml php-mbstring php-ldap php-json

### 3.3 Configure PHP
sudo nano /etc/php/8.3/apache2/php.ini
max_execution_time = 300
memory_limit = 128M
post_max_size = 16M
upload_max_filesize = 2M
max_input_time = 300
max_input_vars = 10000
date.timezone = your time zone

### 3.4 Restart Apache
sudo systemctl restart apache2

## 📦 Step 4: Install Zabbix Server

### 4.1 Add Zabbix Repository
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-1+ubuntu24.04_all.deb
sudo dpkg -i zabbix-release_7.0-1+ubuntu24.04_all.deb
sudo apt update

### 4.2 Install Zabbix Server, Frontend, and Agent
sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent

### 4.3 Import Initial Schema
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix

### 4.4 Configure Zabbix Server
sudo nano /etc/zabbix/zabbix_server.conf
DBHost=localhost
DBName=zabbix
DBUser=zabbix
DBPassword=zabbix_password

### 4.5 Start and Enable Services
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2

### 4.6 Verify Services
sudo systemctl status zabbix-server
sudo systemctl status zabbix-agent
sudo systemctl status apache2

## 🖥️ Step 5: Configure Zabbix Frontend

### 5.1 Access Web Interface
Open a browser and navigate to:
http://yourIPaddress/zabbix

## 🪟 Step 6: Install Zabbix Agent on Windows

### 6.1 Download Agent
Download Zabbix Agent 7.4.7 from zabbix.com/download.

### 6.2 Install Agent
1- Run the installer
2- Configure:
    - Host name: Windows10
    - Zabbix server IP/DNS: yourIPaddress
    - Agent listen port: 10050
    - Server or Proxy for active checks: 127.0.0.1
3- Complete installation

### 6.3 Start Service
Start-Service "Zabbix Agent"
Set-Service "Zabbix Agent" -StartupType Automatic

### 6.4 Verify
Get-Service "Zabbix Agent"

## 🐧 Step 7: Install Zabbix Agent on Ubuntu

### 7.1 Install Agent
sudo apt install -y zabbix-agent

### 7.2 Configure Agent
sudo nano /etc/zabbix/zabbix_agentd.conf
Server=YourIPaddress
ServerActive=YourIPaddress
Hostname=Ubuntu-PC

### 7.3 Start and Enable
sudo systemctl restart zabbix-agent
sudo systemctl enable zabbix-agent

### 7.4 Verify
sudo systemctl status zabbix-agent

## 🔥 Step 8: Configure Firewall

### 8.1 Allow Required Ports
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 10050/tcp
sudo ufw allow 10051/tcp
sudo ufw enable

### 8.2 Verify
sudo ufw status verbose

## ✅ Step 9: Verify Installation

### 9.1 Check Zabbix Server
sudo systemctl status zabbix-server

### 9.2 Check Zabbix Agent
sudo systemctl status zabbix-agent

### 9.3 Check Apache
sudo systemctl status apache2

### 9.4 Check MySQL
sudo systemctl status mysql

### 9.5 Access Web Interface
http://YourIPaddress/zabbix
