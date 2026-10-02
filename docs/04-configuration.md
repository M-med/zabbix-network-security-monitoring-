
# 04 - Configuration

This guide covers the configuration of Zabbix server, agents, and integrations.

## ⚙️ Zabbix Server Configuration

### Main Configuration File
/etc/zabbix/zabbix_server.conf


### Key Parameters

| Parameter | Value | Description |
|-----------|-------|-------------|
| `DBHost` | `localhost` | Database host |
| `DBName` | `zabbix` | Database name |
| `DBUser` | `zabbix` | Database user |
| `DBPassword` | `zabbix_password` | Database password |
| `ListenPort` | `10051` | Zabbix server port |
| `LogFile` | `/var/log/zabbix/zabbix_server.log` | Log file |
| `DebugLevel` | `3` | Debug level |
| `StartPollers` | `5` | Number of pollers |
| `StartTrappers` | `5` | Number of trappers |
| `StartPingers` | `1` | Number of pingers |
| `StartDiscoverers` | `1` | Number of discoverers |

### Apply Changes
sudo systemctl restart zabbix-server

## 🖥️ Zabbix Agent Configuration
### Linux Agent
/etc/zabbix/zabbix_agentd.conf

Server=192.168.1.14
ServerActive=192.168.1.14
Hostname=Ubuntu-PC
ListenPort=10050
ListenIP=0.0.0.0
Timeout=3

### Windows Agent
C:\Program Files\Zabbix Agent\zabbix_agentd.conf

Server=YourIPaddress
ServerActive=YourIPaddress
Hostname=Windows10
ListenPort=10050
ListenIP=0.0.0.0
Timeout=3

## Apply Changes

### Linux
sudo systemctl restart zabbix-agent

### Windows
Restart-Service "Zabbix Agent"

## 🌐 Web Interface Configuration
### Access
http://YourIPaddress/zabbix

### Default Credentials
- Username: Admin
- Password: zabbix

### Change Password
- Click on User Settings (top right)
- Click Change Password
- Enter current and new password
- Click Update

### Configure Timezone
- Navigate to Administration → General
- Select Locale / Timezone
- Set timezone: YourlocalTimezone
- Click Update

## 📧 Email Notifications
### 1. Configure Email Media Type
- Navigate to Administration → Media types
- Click Email
 Configure SMTP settings:
    - SMTP server: smtp.gmail.com
    - SMTP helo: gmail.com
    - SMTP email: your-email@gmail.com
    - SMTP password: your-app-password
    - SMTP port: 587
    - SMTP security: STARTTLS
- Click Update

### 2. Configure User Email
- Navigate to Administration → Users
- Select user (e.g., Admin)
- Click Media tab
- Add email address
- Click Add then Update

### 3. Configure Action
- Navigate to Configuration → Actions
- Click Create action
- Configure:
    - Name: Send email on alert
    - Conditions: Trigger severity ≥ Warning
    - Operations: Send email to user
- Click Add

## 🖥️ Add Monitored Hosts
### 1. Add Windows Host
- Navigate to Configuration → Hosts
- Click Create host
- Configure:
    - Host name: Windows10
    - Groups: Windows servers
    - Agent interface: 192.168.1.6:10050
- Click Templates tab
- Link template: Windows Security Monitoring
- Click Add

### 2. Add Linux Host
- Navigate to Configuration → Hosts
- Click Create host
- Configure:
    - Host name: Ubuntu-PC
    - Groups: Linux servers
    - Agent interface: 192.168.1.50:10050
- Click Templates tab
- Link template: Linux Security Monitoring
- Click Add

## 📊 Import Templates
### 1. Download Templates
- Templates are available in the templates/ folder:
- template_windows_security.xml
- template_linux_security.xml
- template_network_security.xml

### 2. Import via Web Interface
- Navigate to Configuration → Templates
- Click Import (top right)
- Select XML file
- Click Import

### 3. Verify Import
- Navigate to Configuration → Templates and check that templates are listed.

## 🚨 Configure Triggers

### Default Triggers
- Templates include pre-configured triggers:

| Trigger | Severity | Condition |
|-----------|-------|-------------|
| High CPU utilization | Warning | CPU > 90% for 5 min |
| High memory utilization |	Warning | Memory > 90% for 5 min |
| Disk space critically low | Average | Disk > 90% |
| Network interface down | Average | Interface status = down |
| Service not running |	High | Service state ≠ running |
| Multiple failed logins | High | > 5 failed attempts in 5 min |
| Agent unavailable | Average | Agent not reachable |

### Custom Triggers
1- Navigate to Configuration → Hosts
2- Click Triggers for a host
3- Click Create trigger
4- Configure:
    - Name: Custom trigger name
    - Severity: Warning
    - Expression: last(/host/key)>threshold
5- Click Add

## 📈 Create Dashboards

### 1. Create Dashboard
1- Navigate to Monitoring → Dashboards
2- Click Create dashboard
3- Name: Security Overview
4- Click Apply

### 2. Add Widgets
Widget	Purpose
Problems	Display active problems
Host availability	Show host status
CPU utilization	Graph CPU usage
Memory utilization	Graph memory usage
Disk space	Graph disk usage
Network traffic	Graph network traffic

# 3. Save Dashboard
- Click Save to store the dashboard.

## 🔐 Security Configuration
### 1. Enable HTTPS
sudo a2enmod ssl
sudo a2ensite default-ssl
sudo systemctl reload apache2

### 2. Configure TLS for Agents
#### On agent
TLSConnect=cert
TLSAccept=cert
TLSCAFile=/etc/zabbix/certs/ca.crt
TLSCertFile=/etc/zabbix/certs/agent.crt
TLSKeyFile=/etc/zabbix/certs/agent.key

### 3. Configure RBAC
1- Navigate to Administration → User roles
2- Create roles with limited permissions
3- Assign roles to users


