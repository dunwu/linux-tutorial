#!/usr/bin/env bash

###################################################################################
# 安装 mongodb 脚本
# 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install mongodb"

# 下载并解压 mongodb
root=/opt/mongodb
version=3.6.3
mkdir -p ${root}
wget -O ${root}/mongodb-linux-x86_64-${version}.tgz https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-${version}.tgz
cd ${root}
tar zxf mongodb-linux-x86_64-${version}.tgz
mv mongodb-linux-x86_64-${version} mongodb-${version}

mkdir -p /data/db
