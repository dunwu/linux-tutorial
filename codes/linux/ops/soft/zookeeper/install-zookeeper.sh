#!/usr/bin/env bash

###################################################################################
# 安装 zookeeper 脚本
# 适用于所有 linux 发行版本。
# Author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install zookeeper"

root=/opt/zookeeper
version=3.4.12
mkdir -p ${root}
wget -O ${root}/zookeeper-${version}.tar.gz http://mirrors.hust.edu.cn/apache/zookeeper/zookeeper-${version}/zookeeper-${version}.tar.gz
cd ${root}
tar -zxf zookeeper-${version}.tar.gz
cd zookeeper-${version}
