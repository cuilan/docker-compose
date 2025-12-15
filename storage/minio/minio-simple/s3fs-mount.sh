#!/bin/bash

set -e

s3fs -o passwd_file=${HOME}/.passwd-s3fs \
    -o url=http://10.121.1.71:9000 \
    -o allow_other \
    -o no_check_certificate \
    -o use_path_request_style \
    -o umask=000 test /data_hot/data_share/test

# -o dbglevel=info -f -o curldbg：运行时显示更多输出，挂载成功后会占用当前shell前端
# -o umask=000：挂载目录的权限
# -o use_path_request_style：启用不支持的类s3 api的兼容性（必须配置，否则挂载minio存储桶失败）
# -o no_check_certificate：不检查证书
# -o allow_other：允许所有用户访问