#!/usr/bin/env bash

cat << EOF

###################################################################################
# 配置 Redis 脚本
# @system: 适用于 CentOS
# @author: Zhang Peng
###################################################################################

EOF

path=/opt/redis/redis-5.0.4
if [[ -n $1 ]]; then
  path=$1
fi

echo -e "\n>>>>>>>>> config redis"
cp ${path}/redis.conf ${path}/redis.conf.default
wget -N https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/config/redis-remote-access.conf -O ${path}/redis.conf
