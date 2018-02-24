#!/usr/bin/env bash

###################################################################################
# 安装 Redis 脚本
# 适用于所有 linux 发行版本。
# Author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install redis"

# 下载并解压 redis
root=/opt/software/redis
version=4.0.8
mkdir -p ${root}
wget -O ${root}/redis-${version}.tar.gz http://download.redis.io/releases/redis-${version}.tar.gz
cd ${root}
tar zxvf redis-${version}.tar.gz

# 编译
cd redis-${version}
make
