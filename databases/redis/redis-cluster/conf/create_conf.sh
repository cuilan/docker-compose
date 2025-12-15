#!/bin/bash

for port in `seq 6371 6376`; do \
    mkdir -p ${port}/conf \
    && PORT=${port} envsubst < redis-cluster.tmpl > ${port}/conf/redis.conf \
    && mkdir -p ${port}/data; \
done
