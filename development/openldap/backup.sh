#!/bin/bash

# 设置 PATH 环境变量，确保能找到 docker 命令
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

# 获取脚本所在目录的绝对路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="${SCRIPT_DIR}/ldif_backup"
LOG_FILE="${SCRIPT_DIR}/backup.log"

# 创建备份目录（如果不存在）
mkdir -p "${BACKUP_DIR}"

# 记录开始时间
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup started" >> "${LOG_FILE}"

# 生成带日期的文件名（格式：backup_YYYY-MM-DD.ldif）
DATE=$(date +%Y-%m-%d)
BACKUP_FILE="${BACKUP_DIR}/backup_${DATE}.ldif"

# 导出数据到带日期的文件
docker exec openldap slapcat -n 1 > "${BACKUP_FILE}" 2>> "${LOG_FILE}"

# 检查备份是否成功
if [ $? -eq 0 ]; then
    FILE_SIZE=$(du -h "${BACKUP_FILE}" | cut -f1)
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup completed successfully: ${BACKUP_FILE} (Size: ${FILE_SIZE})" >> "${LOG_FILE}"
    exit 0
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup failed!" >> "${LOG_FILE}"
    exit 1
fi