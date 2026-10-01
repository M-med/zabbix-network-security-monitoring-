
## 🧩 Components

### 1. Zabbix Server
- **Role**: Central monitoring engine
- **Host**: Ubuntu Server 24.04 LTS
- **IP**: 192.168.1.14
- **Services**: Zabbix Server, Apache, MySQL, PHP
- **Ports**: 10051 (Zabbix Server), 80 (HTTP), 443 (HTTPS)

### 2. Zabbix Frontend
- **Role**: Web-based user interface
- **Technology**: Apache + PHP
- **URL**: `http://192.168.1.14/zabbix`
- **Features**: Dashboards, configuration, reporting

### 3. Zabbix Database
- **Role**: Data storage
- **Technology**: MySQL 8.0
- **Database**: `zabbix`
- **User**: `zabbix`
- **Port**: 3306 (local only)

### 4. Zabbix Agents
- **Role**: Collect metrics from monitored hosts
- **Hosts**: Windows 10, Ubuntu PC
- **Port**: 10050
- **Communication**: Passive (server polls agent) and Active (agent sends data)

## 🔄 Data Flow

### Passive Checks (Server → Agent)

1- Zabbix Server initiates connection to Agent (port 10050)
2- Agent collects requested metric
3- Agent returns value to Server
4- Server stores value in database
5- Server evaluates triggers
6- Server generates alerts if needed

### Active Checks (Agent → Server)

1- Agent requests list of active checks from Server
2- Server sends list of items to monitor
3- Agent collects metrics locally
4- Agent sends values to Server (port 10051)
5- Server stores values in database
6- Server evaluates triggers
7- Server generates alerts if needed


## 📊 Monitoring Layers

| Layer | Monitored Components | Metrics |
|-------|----------------------|---------|
| **Infrastructure** | CPU, Memory, Disk, Network | Utilization, availability, errors |
| **System** | Services, Processes, Logs | Service status, event logs |
| **Security** | Authentication, Firewall, Antivirus | Failed logins, service state, events |
| **Application** | Web server, Database | Response time, connections |

## 🔐 Security Architecture

### Network Security
- **Firewall (UFW)**: Restricts access to essential ports
- **Network Segmentation**: Zabbix server isolated from production (optional)
- **VPN Access**: For remote administration (recommended)

### Data Security
- **TLS Encryption**: For agent-server communication (optional)
- **Database Encryption**: At-rest encryption (optional)
- **Access Control**: Role-Based Access Control (RBAC) in Zabbix

### Authentication
- **Local Authentication**: Username/password
- **LDAP Integration**: Optional
- **MFA**: Optional (via third-party)

## 📈 Scalability

### Vertical Scaling
- Increase CPU/RAM on Zabbix Server
- Optimize database performance
- Use SSD storage for database

### Horizontal Scaling
- **Zabbix Proxies**: Distribute monitoring load
- **Database Clustering**: MySQL replication
- **Load Balancing**: Apache reverse proxy


## 📌 Design Decisions

- **Ubuntu Server 24.04** : LTS, stable, well-documented
- **MySQL** : Widely used, well-supported by Zabbix 
- **Apache** : Mature, stable, easy to configure 
- **Zabbix 7.0** : Latest LTS, modern features 
- **Passive + Active Agents** : Flexibility and reliability 

## ✅ Summary

The architecture is designed to be:
- **Scalable**: Can grow with the infrastructure
- **Secure**: Follows security best practices
- **Resilient**: Optional HA configuration
- **Maintainable**: Well-documented and modular
