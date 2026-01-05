# Docker Compose Project Collection

[English](README_EN.md) | [中文](README.md)

This is a collection of various Docker Compose configuration files covering services in multiple domains including databases, storage, networking, monitoring, development tools, and media services. All configurations are optimized with health checks, resource limits, and best practices.

## ✨ Features

- 📦 **Ready to Use**: All services are fully configured and ready to start
- 🏥 **Health Checks**: Most services are configured with Docker health checks to ensure service availability
- ⚡ **Resource Limits**: Reasonable CPU and memory limits configured to prevent resource abuse
- 🔒 **Security Configuration**: Follows security best practices to minimize security risks
- 📝 **Chinese Comments**: Detailed Chinese comments for easy understanding and maintenance
- 🔄 **Persistent Storage**: Properly configured data volumes to ensure data persistence

## 🚀 Quick Start

### Basic Usage

```bash
# Navigate to service directory
cd databases/mysql/mysql57-debian

# Start services
docker compose up -d

# View service status
docker compose ps

# View logs
docker compose logs -f

# Stop services
docker compose down

# Stop services and remove volumes
docker compose down -v
```

### Environment Variables Configuration

Most services use `.env` files to manage environment variables:

```bash
# Copy environment variable template
cp .env.example .env

# Edit environment variables
vim .env

# Start services
docker compose up -d
```

## 📁 Directory Structure

The project is organized by functionality for easy management and discovery:

### 📊 databases - Database Services
- **mysql/** - MySQL Database
  - `mysql57-debian/` - MySQL 5.7 (with health checks and resource limits)
  - `mysql8/` - MySQL 8.0
- **postgres/** - PostgreSQL Database
  - `postgres/` - PostgreSQL Standard Edition
  - `postgis/` - PostgreSQL + PostGIS Geospatial Extension
  - `timescaledb-postgis/` - TimescaleDB + PostGIS Time-Series Database
- **redis/** - Redis Cache/Database
  - `redis-simple/` - Redis Standalone
  - `redis-cluster/` - Redis Cluster
  - `redis-stack/` - Redis Stack (with multiple extensions)
  - `redisinsight/` - RedisInsight Visualization Tool (with health checks and resource limits)
- **elasticsearch/** - Elasticsearch Search Engine
  - `es-single.yaml` - Single Node Configuration (with health checks)
  - `es-cluster.yaml` - Cluster Configuration
- **etcd/** - etcd Distributed Key-Value Store
- **zookeeper/** - ZooKeeper Coordination Service

### 💾 storage - Storage/File Services
- **minio/** - MinIO Object Storage (S3 Compatible)
  - `minio-simple/` - Standalone Version
  - `minio-cluster/` - Cluster Version (with Nginx Load Balancer)
- **nfs-server/** - NFS Network File System Service
- **samba/** - Samba File Sharing Service
- **ftp-server/** - FTP File Transfer Service
- **docker-registry/** - Docker Private Image Registry
- **miniserve/** - Lightweight File Server

### 🌐 network - Network/Proxy Services
- **nginx/** - Nginx Web Server (Development Environment)
- **nginx-prod/** - Nginx Production Configuration (with SSL, security config, CORS, etc.)
- **traefik/** - Traefik Reverse Proxy and Load Balancer
- **coredns/** - CoreDNS DNS Server
- **clash/** - Clash Network Proxy Tool

### 📈 monitoring - Monitoring/Operations Tools
- **prometheus/** - Prometheus Monitoring System (with health checks and resource limits)
- **grafana/** - Grafana Visualization Dashboard (with health checks and resource limits)
- **portainer/** - Portainer Container Management Interface
- **rancher/** - Rancher Container Orchestration Platform

### 🛠️ development - Development Tools
- **gitlab/** - GitLab Code Management Platform
- **it-tools/** - IT Tools Collection
- **xxl-job-admin/** - XXL-Job Distributed Task Scheduler
- **youtrack/** - YouTrack Project Management and Issue Tracking
- **openldap/** - OpenLDAP Directory Service

### 🎬 media - Media Services
- **plex/** - Plex Media Server
- **navidrome/** - Navidrome Music Server
- **polaris/** - Polaris Media Management
- **calibre/** - Calibre E-book Management

### ⬇️ download - Download Tools
- **qbittorrent/** - qBittorrent BT Download Client
- **cloud-torrent/** - Cloud Torrent Cloud Download Service

### 📨 messaging - Message Queues
- **rabbitmq/** - RabbitMQ Message Queue
- **rocketmq/** - Apache RocketMQ Distributed Message Middleware

### 🖥️ infrastructure - Infrastructure
- **centos/** - CentOS Container Environment
- **centos-7-desktop/** - CentOS 7 Desktop Environment
- **homepage/** - Homepage Navigation (with health checks, resource limits, and security configuration)

## 🏥 Health Check Guide

Most services are configured with health checks, and Docker automatically monitors service status:

- **MySQL**: Uses `mysqladmin ping` to check service availability
- **Redis**: Uses `redis-cli ping` to check connection status
- **Elasticsearch**: Uses `/_cat/health` endpoint to check cluster status
- **Prometheus**: Uses `/-/healthy` endpoint to check service health
- **Grafana**: Uses `/api/health` endpoint to check service status

View container health status:
```bash
# View all container status (including health status)
docker ps

# View health check details for a specific container
docker inspect <container_name> | grep -A 10 Health
```

## 💪 Resource Limits Guide

Key services are configured with resource limits to prevent a single service from consuming too many resources:

| Service | CPU Limit | Memory Limit | Memory Reservation |
|---------|----------|-------------|-------------------|
| MySQL 5.7 | 8.0 | 16GB | 4GB |
| Prometheus | 2.0 | 4GB | 2GB |
| Grafana | 2.0 | 1GB | 512MB |
| Redis Insight | 1.0 | 512MB | 256MB |
| Homepage | 1.0 | 512MB | 128MB |

> **Note**: These limits can be adjusted in `docker-compose.yaml` according to actual needs.

## 🔒 Security Best Practices

This project follows the following security best practices:

1. **Non-root User Execution**: Run containers with non-root users (e.g., Homepage)
2. **Read-only File System**: Critical services use read-only file systems
3. **Capabilities Restrictions**: Remove unnecessary Linux capabilities
4. **Environment Variable Management**: Store sensitive information in `.env` files
5. **Network Isolation**: Use custom networks to isolate services

## 📚 Common Commands

```bash
# View configuration (without starting services)
docker compose config

# Pull images
docker compose pull

# Start services (foreground)
docker compose up

# Start services (background)
docker compose up -d

# Restart services
docker compose restart

# Stop services (keep containers)
docker compose stop

# Stop and remove containers
docker compose down

# Stop and remove containers and volumes
docker compose down -v

# View logs
docker compose logs

# View logs in real-time
docker compose logs -f

# View logs for a specific service
docker compose logs -f <service_name>

# Enter container
docker compose exec <service_name> bash
```

## 🛠️ Troubleshooting

### Permission Issues

If you encounter permission errors, check the permissions of mounted directories:

```bash
# View directory owner
ls -ld /path/to/volume

# Change directory owner (example with UID 1000)
sudo chown -R 1000:1000 /path/to/volume
```

### Port Conflicts

If you encounter port conflicts, you can modify the port mapping in `docker-compose.yaml`:

```yaml
ports:
  - "8080:3306"  # Change host port to 8080
```

### View Container Resource Usage

```bash
# View resource usage for all containers
docker stats

# View resource usage for a specific container
docker stats <container_name>
```

## 📝 Contributing

Welcome to submit Issues and Pull Requests!

Before submitting a PR, please ensure:
- Configuration files include necessary Chinese comments
- Key services have health checks configured
- Resource limits are set reasonably
- Security best practices are followed

## 📄 License

MIT License

## 🔗 Related Links

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Docker Hub](https://hub.docker.com/)
