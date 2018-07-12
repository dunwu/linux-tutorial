#!/usr/bin/env bash

###################################################################################
# 安装 kafka 脚本
# 适用于所有 linux 发行版本。
# Author: Zhang Peng
###################################################################################

# 下载并解压 kafka
echo -e "\n>>>>>>>>> install kafka"

root=/opt/software/kafka
version=2.11-1.1.0
mkdir -p ${root}
wget -O ${root}/kafka_${version}.tgz http://mirrors.shu.edu.cn/apache/kafka/1.1.0/kafka_${version}.tgz
cd ${root}
tar -xzf kafka_${version}.tgz
