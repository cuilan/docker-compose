# TimescaleDB + PostGIS 高性能配置

## 使用自动化脚本

```bash
# 运行自动化部署脚本
sudo ./setup.sh

# 编辑环境变量，设置数据库密码
vim .env

# 启动服务
docker-compose up -d

docker-compose logs -f

docker-compose restart
```

## 系统优化（重要）

**注意**：如果使用 `setup.sh` 脚本，这些步骤会自动处理。

在启动容器之前，需要优化系统参数：

```bash
# 编辑 /etc/sysctl.conf，添加以下内容：
sudo vim /etc/sysctl.conf

# 添加以下配置：
kernel.shmmax = 34359738368
kernel.shmall = 5242880
kernel.shmmni = 4096
vm.overcommit_memory = 2
vm.swappiness = 1

# 应用配置
sudo sysctl -p

# 增加共享内存大小（/dev/shm）
# 方法一：临时挂载（重启后失效）
sudo mount -o remount,size=32G /dev/shm

# 方法二：永久设置（推荐）
# 编辑 /etc/fstab，添加或修改以下行：
# tmpfs /dev/shm tmpfs defaults,size=32G 0 0
# 然后执行：
# sudo mount -o remount /dev/shm
```

## 验证安装

```bash
# 等待容器完全启动（首次启动可能需要 1-2 分钟）
docker-compose ps

# 查看启动日志
docker-compose logs -f timescaledb-postgis

# 连接到数据库
docker exec -it timescaledb-postgis psql -U postgres

# 在 psql 中执行：
\dx  # 查看已安装的扩展
SELECT * FROM pg_extension;

# 验证 TimescaleDB
SELECT default_version, installed_version FROM pg_available_extensions WHERE name = 'timescaledb';

# 验证 PostGIS
SELECT PostGIS_version();
```

## 性能优化说明

### 内存配置

- **shared_buffers**: 16GB（系统内存的 25%，用于缓存常用数据）
- **effective_cache_size**: 48GB（系统内存的 75%，告诉优化器可用缓存大小）
- **work_mem**: 64MB（每个排序/哈希操作的工作内存，注意：max_connections × work_mem 不应超过系统内存）
- **maintenance_work_mem**: 2GB（用于 VACUUM、CREATE INDEX 等维护操作）

**内存计算公式**：
- shared_buffers = RAM × 25% = 64GB × 25% = 16GB
- effective_cache_size = RAM × 75% = 64GB × 75% = 48GB
- work_mem = (RAM - shared_buffers) / (max_connections × 3) ≈ 64MB

### CPU 配置

- **max_parallel_workers**: 24（最大并行工作进程数，建议为 CPU 核心数的 50%）
- **max_parallel_workers_per_gather**: 8（单个查询的最大并行度）
- **max_worker_processes**: 24（后台工作进程总数）

**CPU 配置说明**：
- 56 核 CPU 可以支持更高的并行度
- 并行查询适用于大表扫描和聚合操作
- 对于 OLTP 负载，可以适当降低并行度

### 存储优化

- **数据目录**: 挂载到 `/data/timescaledb/data`（12TB 机械盘）
  - TimescaleDB HA 镜像使用 `/home/postgres/pgdata/data` 作为容器内数据目录
  - 主机目录 `/data/timescaledb/data` 挂载到容器内的 `/home/postgres/pgdata/data`
- **WAL 目录**: WAL 文件位于数据目录下的 `pg_wal` 子目录
  - 如果需要单独挂载 WAL 到 SSD，可以挂载到 `/home/postgres/pgdata/data/pg_wal`
- **random_page_cost**: 4.0（针对机械盘，SSD 应设置为 1.1）
- **effective_io_concurrency**: 2（机械盘并发 IO 数，SSD 可设置为 200+）

**存储性能建议**：
1. 如果系统盘（SSD）空间充足，可以将 WAL 目录单独挂载到 SSD
2. 使用 `noatime` 挂载选项可以提升性能
3. 考虑使用 LVM 或 ZFS 进行存储管理

**重要提示**：
- TimescaleDB HA 镜像的数据目录路径与标准 PostgreSQL 镜像不同
- 标准镜像使用 `/var/lib/postgresql/data`
- TimescaleDB HA 镜像使用 `/home/postgres/pgdata/data`

### 注意事项

1. **共享内存**: 确保系统的 `/dev/shm` 至少 20GB（必须大于 shared_buffers）
2. **权限**: 数据目录需要正确的权限（PostgreSQL 容器内用户通常是 999:999）
3. **WAL 目录**: 如果系统盘空间充足，建议将 WAL 目录放在 SSD 上以提升写入性能
4. **备份**: 定期备份数据到 `/data/timescaledb/backup`
5. **监控**: 建议配置监控系统（如 Prometheus + Grafana）来跟踪性能指标
6. **调优**: 根据实际负载情况调整 `postgresql.conf` 中的参数
