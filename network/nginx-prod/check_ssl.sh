#!/bin/bash

#echo -n "脚本后跟证书的crt文件,XXXX.crt  "
#read name
input_file=$1

openssl x509 -in $input_file -noout -dates
#openssl x509 -in $name -noout -dates