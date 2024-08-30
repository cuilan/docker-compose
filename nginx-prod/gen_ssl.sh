#!/bin/bash

# Generate SSL certificate
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout ./ssl/weatsoho_com.key -out ./ssl/weatsoho_com.crt -subj "/C=CN/ST=Beijing/L=Beijing/O=weatsoho/CN=weatsoho.com"
