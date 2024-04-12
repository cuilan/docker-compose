#!/bin/bash

# 进入容器
docker exec -it redis-6371 /bin/sh

# 创建集群
/usr/local/bin/redis-cli -a 123456 --cluster create redis-6371:6371 redis-6372:6372 redis-6373:6373 redis-6374:6374 redis-6375:6375 redis-6376:6376 --cluster-replicas 1

# 检查集群
docker exec -it redis-6371 /usr/local/bin/redis-cli -a 123456 --cluster check redis-6371:6371
