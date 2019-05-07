#!/usr/bin/env bash

cat << EOF

###################################################################################
# 安装 Redis 脚本
# @system: 适用于 CentOS
# @author: Zhang Peng
###################################################################################

EOF

version=5.0.4
if [[ -n $1 ]]; then
  version=$1
fi

root=/opt/redis
if [[ -n $2 ]]; then
  root=$2
fi

echo -e "\n>>>>>>>>> install libs"
yum install -y zlib zlib-devel gcc-c++ libtool openssl openssl-devel tcl

echo -e "\n>>>>>>>>> download redis"
mkdir -p ${root}
wget -O ${root}/redis-${version}.tar.gz http://download.redis.io/releases/redis-${version}.tar.gz

echo -e "\n>>>>>>>>> install redis"
tar zxf ${root}/redis-${version}.tar.gz -C ${root}
cd ${root}/redis-${version}
make && make install
cd -
