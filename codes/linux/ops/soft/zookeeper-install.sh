#!/usr/bin/env bash

cat << EOF

###################################################################################
# 安装 zookeeper 脚本
# @system: 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

EOF

version=3.4.12
if [[ -n $1 ]]; then
  version=$1
fi

root=/opt/zookeeper
if [[ -n $2 ]]; then
  root=$2
fi

echo -e "\n>>>>>>>>> download zookeeper"
mkdir -p ${root}
wget -O ${root}/zookeeper-${version}.tar.gz http://mirrors.hust.edu.cn/apache/zookeeper/zookeeper-${version}/zookeeper-${version}.tar.gz

echo -e "\n>>>>>>>>> install zookeeper"
tar zxf ${root}/zookeeper-${version}.tar.gz -C ${root}
