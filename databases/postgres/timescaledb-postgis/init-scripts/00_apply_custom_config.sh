#!/bin/bash
# 应用自定义 PostgreSQL 配置文件
# 这个脚本会在数据库初始化时执行

set -e

echo "=========================================="
echo "应用自定义 PostgreSQL 配置"
echo "=========================================="

# 检查自定义配置文件是否存在
if [ ! -f /etc/postgresql-custom/postgresql.conf ]; then
    echo "警告: 未找到自定义配置文件 /etc/postgresql-custom/postgresql.conf"
    echo "将使用默认配置"
    exit 0
fi

# 等待 PostgreSQL 完成初始化
echo "等待 PostgreSQL 初始化完成..."
sleep 5

# 备份原始配置文件
if [ -f "$PGDATA/postgresql.conf" ]; then
    echo "备份原始配置文件..."
    cp "$PGDATA/postgresql.conf" "$PGDATA/postgresql.conf.bak.$(date +%Y%m%d_%H%M%S)"
fi

# 复制自定义配置文件
echo "复制自定义配置文件到 $PGDATA/postgresql.conf"
cp /etc/postgresql-custom/postgresql.conf "$PGDATA/postgresql.conf"

# 设置正确的权限
chown postgres:postgres "$PGDATA/postgresql.conf"
chmod 600 "$PGDATA/postgresql.conf"

echo "✓ 自定义配置已应用"
echo "注意: 配置将在容器重启后生效"
echo "=========================================="
