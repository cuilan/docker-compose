#!/bin/bash

# wait for the docker-compose depends_on start up, so sleep N seconds.
sleep 3

master_1=
master_2=
master_3=
slave_1=
slave_2=
slave_3=

docker exec --rm -it redis:7-alpine redis-cli \
    --cluster create $master_1:6379 $master_2:6379 $master_3:6379 $slave_1:6379 $slave_2:6379 $slave_3:6379 \
    --cluster-replicas 1
