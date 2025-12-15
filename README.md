# Docker Compose 项目集合

这是一个包含各种 Docker Compose 配置文件的集合，涵盖了数据库、存储、网络、监控、开发工具、媒体服务等多个领域的服务。

## 📁 目录结构

项目按照功能分类组织，便于管理和查找：

### 📊 databases - 数据库服务
- `mysql/` - MySQL 数据库（包含 MySQL 5.7 和 MySQL 8）
- `postgres/` - PostgreSQL 数据库（包含 PostGIS 扩展）
- `redis/` - Redis 缓存/数据库（包含集群、单机、Stack 版本）
- `elasticsearch/` - Elasticsearch 搜索引擎
- `etcd/` - etcd 分布式键值存储
- `zookeeper/` - ZooKeeper 协调服务

### 💾 storage - 存储/文件服务
- `minio/` - MinIO 对象存储（S3 兼容，包含集群和单机版本）
- `nfs-server/` - NFS 网络文件系统服务
- `samba/` - Samba 文件共享服务
- `ftp-server/` - FTP 文件传输服务
- `docker-registry/` - Docker 镜像仓库
- `miniserve/` - 轻量级文件服务器

### 🌐 network - 网络/代理服务
- `nginx/` - Nginx Web 服务器（开发环境）
- `nginx-prod/` - Nginx 生产环境配置
- `traefik/` - Traefik 反向代理和负载均衡
- `coredns/` - CoreDNS DNS 服务器
- `clash/` - Clash 网络代理工具

### 📈 monitoring - 监控/运维工具
- `prometheus/` - Prometheus 监控系统
- `grafana/` - Grafana 可视化面板
- `portainer/` - Portainer 容器管理界面
- `rancher/` - Rancher 容器编排平台

### 🛠️ development - 开发工具
- `gitlab/` - GitLab 代码管理平台
- `it-tools/` - IT 工具集合
- `xxl-job-admin/` - XXL-Job 分布式任务调度
- `youtrack/` - YouTrack 项目管理和问题跟踪
- `openldap/` - OpenLDAP 目录服务

### 🎬 media - 媒体服务
- `plex/` - Plex 媒体服务器
- `navidrome/` - Navidrome 音乐服务器
- `polaris/` - Polaris 媒体管理
- `calibre/` - Calibre 电子书管理

### ⬇️ download - 下载工具
- `qbittorrent/` - qBittorrent BT 下载客户端
- `cloud-torrent/` - Cloud Torrent 云下载服务

### 📨 messaging - 消息队列
- `rabbitmq/` - RabbitMQ 消息队列

### 🖥️ infrastructure - 基础设施
- `centos/` - CentOS 容器环境
- `centos-7-desktop/` - CentOS 7 桌面环境
- `homepage/` - 首页导航
