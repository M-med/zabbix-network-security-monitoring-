# 01 - Introduction

## 📖 Project Overview

The **Zabbix Network Security Monitoring** project aims to deploy a robust, centralized monitoring solution using **Zabbix 7** to supervise the availability, performance, and security of an IT infrastructure.

This project was developed in the context of a cybersecurity training program at **FRDISI** (Fondation de Recherche, de Développement et d'Innovation en Sciences et Ingénierie), with the goal of demonstrating practical skills in network monitoring, security event detection, and incident response.

## 🎯 Objectives

### Primary Objectives
- Deploy a Zabbix server on Ubuntu Server 24.04 LTS
- Configure agents on Windows and Linux hosts
- Monitor system availability, performance, and security events
- Set up alerts for critical security incidents

### Secondary Objectives
- Implement security hardening for the Zabbix infrastructure
- Create custom dashboards for security monitoring
- Document the entire deployment process
- Provide reusable templates and scripts for future deployments

## 🔍 Scope

### In Scope
- Zabbix Server installation and configuration
- Zabbix Agent deployment on Windows 10 and Ubuntu
- Security monitoring (services, logs, events)
- Performance monitoring (CPU, memory, disk, network)
- Alerting and notification configuration
- Documentation and knowledge transfer

### Out of Scope
- Integration with external SIEM platforms
- Advanced automation (SOAR)
- Cloud-native monitoring (AWS, Azure, GCP)
- Network device monitoring via SNMP (covered in templates but not fully deployed)

## 🛠️ Technologies Used

-  **Ubuntu Server** 24.04 LTS : Host OS for Zabbix Server
-  **Zabbix** 7.0 : Monitoring platform 
-  **Apache** 2.4.58 : Web server for Zabbix frontend
-  **MySQL** 8.0.45 : Database backend
-  **PHP** 8.3 : Frontend language
-  **Windows 10** : Monitored client
-  **Ubuntu Desktop** : Monitored client 

## 📋 Prerequisites

### Hardware Requirements
- **Zabbix Server**: 2 CPU cores, 4 GB RAM, 50 GB disk
- **Monitored Hosts**: Minimal (agent only)

### Software Requirements
- Ubuntu Server 24.04 LTS (clean installation)
- Internet access for package installation
- Basic knowledge of Linux command line
- Basic knowledge of networking (IP, DNS, firewall)

### Network Requirements
- Static IP address for Zabbix Server
- Open ports: 80 (HTTP), 443 (HTTPS), 10050 (Zabbix Agent), 10051 (Zabbix Server)
- DNS resolution (optional but recommended)

## 👥 Target Audience

This documentation is intended for:
- System administrators
- Security analysts
- DevOps engineers
- Students learning cybersecurity
- IT professionals implementing monitoring solutions

## 📅 Project Timeline

- **Phase 1** | Week 1 | Research and planning 
- **Phase 2** | Week 2 | Zabbix Server installation 
- **Phase 3** | Week 3 | Agent deployment and configuration 
- **Phase 4** | Week 4 | Monitoring setup and alerting 
- **Phase 5** | Week 5 | Security hardening and documentation 

## 📚 References

- [Zabbix Documentation](https://www.zabbix.com/documentation/current/)
- [Ubuntu Server Guide](https://ubuntu.com/server/docs)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [ISO 27001](https://www.iso.org/isoiec-27001-information-security.html)

## ✅ Summary

This project provides a complete, production-ready monitoring solution based on Zabbix 7, with a strong focus on security. The following documentation will guide you through every step of the deployment, from architecture design to troubleshooting.
