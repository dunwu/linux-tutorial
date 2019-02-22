#!/usr/bin/env bash

###################################################################################
# 安装 Redis 脚本
# 适用于所有 linux 发行版本。
# 注意：安装 nginx 需要依赖以下库，需预先安装：
# yum install -y zlib zlib-devel gcc-c++ libtool openssl openssl-devel tcl
# Author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install redis"

# 下载并解压 redis
root=/opt/redis
version=4.0.8
mkdir -p ${root}
wget -O ${root}/redis-${version}.tar.gz http://download.redis.io/releases/redis-${version}.tar.gz
cd ${root}systemctl
tar zxvf redis-${version}.tar.gz

# 编译
cd redis-${version}
make
