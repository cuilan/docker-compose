#!/bin/bash

# 1. 确认文件在当前目录
ls -lh clean.ldif

# 2. 复制文件到容器的 /tmp 目录
docker cp clean.ldif openldap:/tmp/restore.ldif

# 3. 导入数据
docker exec -it openldap ldapadd -x -H ldap://localhost -D "cn=admin,dc=weattech,dc=com" -w "123456" -f /tmp/restore.ldif -c

# 其他常用命令

# 导出数据
# docker exec openldap slapcat -n 1 > raw_dump.ldif
# 清洗 entryUUID, createTimestamp 等系统属性
# cat raw_dump.ldif | \
# grep -vE "^(entryUUID|creatorsName|createTimestamp|modifiersName|modifyTimestamp|structuralObjectClass|entryCSN|contextCSN):" \
# > clean.ldif

# 导入数据
# docker exec openldap ldapadd -x -H ldap://localhost -D "cn=admin,dc=weattech,dc=com" -w "123456" -f /tmp/restore.ldif -c

# 检查数据
# docker exec openldap ldapsearch -x -H ldap://localhost -D "cn=admin,dc=weattech,dc=com" -w "123456" -b "dc=weattech,dc=com" -s sub "(objectClass=*)"

# 删除数据
# docker exec openldap ldapdelete -x -H ldap://localhost -D "cn=admin,dc=weattech,dc=com" -w "123456" -r "dc=weattech,dc=com"