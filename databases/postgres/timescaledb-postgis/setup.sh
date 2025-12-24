#!/bin/bash
# TimescaleDB + PostGIS 部署脚本
# 用于准备环境和启动服务

set -e

echo "=========================================="
echo "TimescaleDB + PostGIS 部署脚本"
echo "=========================================="

# 检查是否为 root 用户
if [ "$EUID" -ne 0 ]; then 
    echo "请使用 sudo 运行此脚本"
    exit 1
fi

# 1. 创建数据目录
echo "1. 创建数据目录..."
mkdir -p /data/timescaledb/{data,backup,logs}
echo "✓ 数据目录创建完成"

# 2. 设置目录权限（PostgreSQL 容器内用户通常是 1000:1000）
echo "2. 设置目录权限..."
chown -R 1000:1000 /data/timescaledb
echo "✓ 权限设置完成"

# 3. 检查共享内存大小
echo "3. 检查共享内存大小..."
SHM_SIZE=$(df -h /dev/shm | awk 'NR==2 {print $2}' | sed 's/G//')
if [ -z "$SHM_SIZE" ] || [ "$SHM_SIZE" -lt 20 ]; then
    echo "警告: /dev/shm 大小不足 32GB，当前为 ${SHM_SIZE}GB"
    echo "建议执行: sudo mount -o remount,size=32G /dev/shm"
    echo "或编辑 /etc/fstab 永久设置"
    echo "tmpfs /dev/shm tmpfs defaults,size=32G 0 0"
else
    echo "✓ 共享内存大小: ${SHM_SIZE}GB"
fi

# 4. 检查系统参数
echo "4. 检查系统参数..."
if ! grep -q "kernel.shmmax" /etc/sysctl.conf 2>/dev/null; then
    echo "建议在 /etc/sysctl.conf 中添加以下配置："
    echo "kernel.shmmax = 34359738368  # 32GB 共享内存"
    echo "kernel.shmall = 5242880"
    echo "kernel.shmmni = 4096"
    echo "vm.overcommit_memory = 2"
    echo "vm.swappiness = 1"
    echo "# 网络优化（使用 host 网络模式时需要）"
    echo "net.core.somaxconn = 4096"
    echo "net.ipv4.tcp_max_syn_backlog = 4096"
    echo ""
    read -p "是否现在添加这些配置？(y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cat >> /etc/sysctl.conf << EOF

# PostgreSQL/TimescaleDB 优化参数
# 共享内存设置（32GB）
kernel.shmmax = 34359738368
kernel.shmall = 5242880
kernel.shmmni = 4096
# 内存管理
vm.overcommit_memory = 2
vm.swappiness = 1
# 网络优化（使用 host 网络模式时需要）
net.core.somaxconn = 4096
net.ipv4.tcp_max_syn_backlog = 4096
EOF
        sysctl -p
        echo "✓ 系统参数已更新"
    fi
else
    echo "✓ 系统参数已配置"
    # 检查是否包含网络参数（host 网络模式需要）
    if ! grep -q "net.core.somaxconn" /etc/sysctl.conf 2>/dev/null; then
        echo "提示: 检测到使用 host 网络模式，建议添加网络优化参数："
        echo "  net.core.somaxconn = 4096"
        echo "  net.ipv4.tcp_max_syn_backlog = 4096"
    fi
fi

# 5. 检查环境变量文件
echo "5. 检查环境变量文件..."
if [ ! -f .env ]; then
    if [ -f .env.example ]; then
        cp .env.example .env
        echo "✓ 已创建 .env 文件，请编辑设置数据库密码"
    else
        echo "警告: 未找到 .env 文件，请手动创建"
    fi
else
    echo "✓ .env 文件已存在"
fi

# 6. 设置脚本执行权限
echo "6. 设置脚本执行权限..."
chmod +x init-scripts/*.sh 2>/dev/null || true
echo "✓ 权限设置完成"

echo ""
echo "=========================================="
echo "环境准备完成！"
echo "=========================================="
echo ""
echo "下一步："
echo "1. 编辑 .env 文件，设置 POSTGRES_PASSWORD"
echo "2. 运行: docker-compose up -d"
echo "3. 查看日志: docker-compose logs -f"
echo ""
