#!/bin/bash

set -e

# 设置参数
sysctl -w vm.max_map_count=262144