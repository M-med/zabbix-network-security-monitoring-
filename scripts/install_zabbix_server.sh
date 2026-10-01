#!/bin/bash

#############################################
# Zabbix Server Installation Script
# Ubuntu Server 24.04 LTS
# Author: M-med M2M
# Date: 2026
#############################################

set -e

echo "=========================================="
echo "  Zabbix Server Installation Script"
echo "=========================================="

# Vérifier les privilèges root
if [ "$EUID" -ne 0 ]; then
    echo "[!] Ce script doit être exécuté en tant que root (sudo)."
    exit 1
fi

# Variables
DB_NAME="zabbix"
DB_USER="zabbix"
DB_PASSWORD="zabbix_password"
ZABBIX_VERSION="7.0"
UBUNTU_VERSION="24.04"

echo "[+] Mise à jour du système..."
apt update && apt upgrade -y

echo "[+] Installation des dépendances..."
apt install -y apache2 mysql-server php php-mysql php-gd php-bcmath php-net-socket php-gettext php-xml php-mbstring php-ldap php-json

echo "[+] Ajout du dépôt Zabbix..."
wget https://repo.zabbix.com/zabbix/${ZABBIX_VERSION}/ubuntu/pool/main/z/zabbix-release/zabbix-release_${ZABBIX_VERSION}-1+ubuntu${UBUNTU_VERSION}_all.deb
dpkg -i zabbix-release_${ZABBIX_VERSION}-1+ubuntu${UBUNTU_VERSION}_all.deb
apt update

echo "[+] Installation de Zabbix Server, Frontend et Agent..."
apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent

echo "[+] Configuration de la base de données MySQL..."
mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;"
mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';"
mysql -e "SET GLOBAL log_bin_trust_function_creators = 1;"
mysql -e "FLUSH PRIVILEGES;"

echo "[+] Import du schéma initial..."
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -u${DB_USER} -p${DB_PASSWORD} ${DB_NAME}

echo "[+] Configuration de Zabbix Server..."
sed -i "s/^# DBPassword=.*/DBPassword=${DB_PASSWORD}/" /etc/zabbix/zabbix_server.conf

echo "[+] Redémarrage des services..."
systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2

echo "=========================================="
echo "  Installation terminée avec succès !"
echo "=========================================="
echo ""
echo "Accédez à l'interface web :"
echo "  http://$(hostname -I | awk '{print $1}')/zabbix"
echo ""
echo "Identifiants par défaut :"
echo "  Utilisateur : Admin"
echo "  Mot de passe : zabbix"
echo ""
echo "⚠️  Pensez à changer le mot de passe par défaut !"
