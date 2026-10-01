#!/bin/bash

#############################################
# Zabbix Database Backup Script
# Author: M-Med M2M
# Date: 2026
#############################################

set -e

# Variables
DB_NAME="zabbix"
DB_USER="zabbix"
DB_PASSWORD="zabbix_password"
BACKUP_DIR="/backup/zabbix"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="${BACKUP_DIR}/zabbix_backup_${DATE}.sql.gz"
RETENTION_DAYS=30

# Créer le dossier de backup
mkdir -p ${BACKUP_DIR}

echo "[+] Sauvegarde de la base de données Zabbix..."

# Dump et compression
mysqldump -u${DB_USER} -p${DB_PASSWORD} --single-transaction --routines --triggers ${DB_NAME} | gzip > ${BACKUP_FILE}

echo "[+] Sauvegarde créée : ${BACKUP_FILE}"

# Supprimer les anciennes sauvegardes
find ${BACKUP_DIR} -name "zabbix_backup_*.sql.gz" -mtime +${RETENTION_DAYS} -delete

echo "[+] Anciennes sauvegardes supprimées (> ${RETENTION_DAYS} jours)"
echo "[+] Terminé !"
