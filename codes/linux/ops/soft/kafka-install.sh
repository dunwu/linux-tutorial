#!/usr/bin/env bash

cat << EOF

###################################################################################
# 安装 Kafka 脚本
# @system: 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

EOF

version=2.2.0
if [[ -n $1 ]]; then
  version=$1
fi

root=/opt/kafka
if [[ -n $2 ]]; then
  root=$2
fi

echo -e "\n>>>>>>>>> download kafka"
mkdir -p ${root}
wget -O ${root}/kafka_2.12-${version}.tgz http://mirrors.tuna.tsinghua.edu.cn/apache/kafka/${version}/kafka_2.12-${version}.tgz

echo -e "\n>>>>>>>>> install kafka"
tar zxf ${root}/kafka_2.12-${version}.tgz -C ${root}
