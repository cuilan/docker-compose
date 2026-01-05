# Docker Compose 项目集合

[English](README_EN.md) | [中文](README.md)

这是一个包含各种 Docker Compose 配置文件的集合，涵盖了数据库、存储、网络、监控、开发工具、媒体服务等多个领域的服务。所有配置都经过优化，包含健康检查、资源限制和最佳实践配置。

## ✨ 特性

- 📦 **开箱即用**：所有服务都配置完善，可直接启动使用
- 🏥 **健康检查**：大部分服务配置了 Docker 健康检查，确保服务可用性
- ⚡ **资源限制**：合理配置 CPU 和内存限制，避免资源滥用
- 🔒 **安全配置**：遵循安全最佳实践，最小化安全风险
- 📝 **中文注释**：详细的中文注释，便于理解和维护
- 🔄 **持久化存储**：合理配置数据卷，确保数据不丢失

## 🚀 快速开始

### 基本使用

```bash
# 进入服务目录
cd databases/mysql/mysql57-debian

# 启动服务
docker compose up -d

# 查看服务状态
docker compose ps

# 查看日志
docker compose logs -f

# 停止服务
docker compose down

# 停止服务并删除数据卷
docker compose down -v
```

### 环境变量配置

大部分服务使用 `.env` 文件管理环境变量：

```bash
# 复制环境变量模板
cp .env.example .env

# 编辑环境变量
vim .env

# 启动服务
docker compose up -d
```

## 📁 目录结构

项目按照功能分类组织，便于管理和查找：

### 📊 databases - 数据库服务
- **mysql/** - MySQL 数据库
  - `mysql57-debian/` - MySQL 5.7（包含健康检查、资源限制）
  - `mysql8/` - MySQL 8.0
- **postgres/** - PostgreSQL 数据库
  - `postgres/` - PostgreSQL 标准版
  - `postgis/` - PostgreSQL + PostGIS 地理空间扩展
  - `timescaledb-postgis/` - TimescaleDB + PostGIS 时序数据库
- **redis/** - Redis 缓存/数据库
  - `redis-simple/` - Redis 单机版
  - `redis-cluster/` - Redis 集群
  - `redis-stack/` - Redis Stack（包含多种扩展）
  - `redisinsight/` - RedisInsight 可视化工具（包含健康检查、资源限制）
- **elasticsearch/** - Elasticsearch 搜索引擎
  - `es-single.yaml` - 单节点配置（包含健康检查）
  - `es-cluster.yaml` - 集群配置
- **etcd/** - etcd 分布式键值存储
- **zookeeper/** - ZooKeeper 协调服务

### 💾 storage - 存储/文件服务
- **minio/** - MinIO 对象存储（S3 兼容）
  - `minio-simple/` - 单机版
  - `minio-cluster/` - 集群版（包含 Nginx 负载均衡）
- **nfs-server/** - NFS 网络文件系统服务
- **samba/** - Samba 文件共享服务
- **ftp-server/** - FTP 文件传输服务
- **docker-registry/** - Docker 私有镜像仓库
- **miniserve/** - 轻量级文件服务器

### 🌐 network - 网络/代理服务
- **nginx/** - Nginx Web 服务器（开发环境）
- **nginx-prod/** - Nginx 生产环境配置（包含 SSL、安全配置、CORS 等）
- **traefik/** - Traefik 反向代理和负载均衡
- **coredns/** - CoreDNS DNS 服务器
- **clash/** - Clash 网络代理工具

### 📈 monitoring - 监控/运维工具
- **prometheus/** - Prometheus 监控系统（包含健康检查、资源限制）
- **grafana/** - Grafana 可视化面板（包含健康检查、资源限制）
- **portainer/** - Portainer 容器管理界面
- **rancher/** - Rancher 容器编排平台

### 🛠️ development - 开发工具
- **gitlab/** - GitLab 代码管理平台
- **it-tools/** - IT 工具集合
- **xxl-job-admin/** - XXL-Job 分布式任务调度
- **youtrack/** - YouTrack 项目管理和问题跟踪
- **openldap/** - OpenLDAP 目录服务

### 🎬 media - 媒体服务
- **plex/** - Plex 媒体服务器
- **navidrome/** - Navidrome 音乐服务器
- **polaris/** - Polaris 媒体管理
- **calibre/** - Calibre 电子书管理

### ⬇️ download - 下载工具
- **qbittorrent/** - qBittorrent BT 下载客户端
- **cloud-torrent/** - Cloud Torrent 云下载服务

### 📨 messaging - 消息队列
- **rabbitmq/** - RabbitMQ 消息队列
- **rocketmq/** - Apache RocketMQ 分布式消息中间件

### 🖥️ infrastructure - 基础设施
- **centos/** - CentOS 容器环境
- **centos-7-desktop/** - CentOS 7 桌面环境
- **homepage/** - Homepage 首页导航（包含健康检查、资源限制、安全配置）

## 🏥 健康检查说明

大部分服务已配置健康检查，Docker 会自动监控服务状态：

- **MySQL**: 使用 `mysqladmin ping` 检查服务可用性
- **Redis**: 使用 `redis-cli ping` 检查连接状态
- **Elasticsearch**: 使用 `/_cat/health` 端点检查集群状态
- **Prometheus**: 使用 `/-/healthy` 端点检查服务健康
- **Grafana**: 使用 `/api/health` 端点检查服务状态

查看容器健康状态：
```bash
# 查看所有容器状态（包含健康状态）
docker ps

# 查看特定容器的健康检查详情
docker inspect <container_name> | grep -A 10 Health
```

## 💪 资源限制说明

关键服务已配置资源限制，防止单个服务占用过多资源：

| 服务 | CPU 限制 | 内存限制 | 内存预留 |
|-----|---------|---------|---------|
| MySQL 5.7 | 8.0 | 16GB | 4GB |
| Prometheus | 2.0 | 4GB | 2GB |
| Grafana | 2.0 | 1GB | 512MB |
| Redis Insight | 1.0 | 512MB | 256MB |
| Homepage | 1.0 | 512MB | 128MB |

> **注意**: 这些限制可以根据实际需求在 `docker-compose.yaml` 中调整。

## 🔒 安全最佳实践

本项目遵循以下安全最佳实践：

1. **非 root 用户运行**：使用非 root 用户运行容器（如 Homepage）
2. **只读文件系统**：关键服务使用只读文件系统
3. **Capabilities 限制**：删除不必要的 Linux capabilities
4. **环境变量管理**：敏感信息存储在 `.env` 文件中
5. **网络隔离**：使用自定义网络隔离服务

## 📚 常用命令

```bash
# 查看配置（不启动服务）
docker compose config

# 拉取镜像
docker compose pull

# 启动服务（前台）
docker compose up

# 启动服务（后台）
docker compose up -d

# 重启服务
docker compose restart

# 停止服务（保留容器）
docker compose stop

# 停止并删除容器
docker compose down

# 停止并删除容器和数据卷
docker compose down -v

# 查看日志
docker compose logs

# 实时查看日志
docker compose logs -f

# 查看特定服务的日志
docker compose logs -f <service_name>

# 进入容器
docker compose exec <service_name> bash
```

## 🛠️ 故障排查

### 权限问题

如果遇到权限错误，检查挂载目录的权限：

```bash
# 查看目录所有者
ls -ld /path/to/volume

# 修改目录所有者（以 UID 1000 为例）
sudo chown -R 1000:1000 /path/to/volume
```

### 端口冲突

如果遇到端口冲突，可以修改 `docker-compose.yaml` 中的端口映射：

```yaml
ports:
  - "8080:3306"  # 将主机端口改为 8080
```

### 查看容器资源使用

```bash
# 查看所有容器的资源使用情况
docker stats

# 查看特定容器的资源使用
docker stats <container_name>
```

## 📝 贡献指南

欢迎提交 Issue 和 Pull Request！

在提交 PR 之前，请确保：
- 配置文件包含必要的中文注释
- 关键服务已配置健康检查
- 合理设置资源限制
- 遵循安全最佳实践

## 📄 许可证

MIT License

## 🔗 相关链接

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Docker Hub](https://hub.docker.com/)
