#!/usr/bin/env bash

cat << EOF

###################################################################################
# 安装 Kafka 脚本
# @system: 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

EOF

if [[ $# -lt 1 ]] || [[ $# -lt 2 ]];then
    echo "Usage: sh kafka-install.sh [version] [path]"
    echo -e "Example: sh kafka-install.sh 2.2.0 /opt/kafka\n"
fi

version=2.2.0
if [[ -n $1 ]]; then
  version=$1
fi

root=/opt/kafka
if [[ -n $2 ]]; then
  root=$2
fi

echo "Current execution: install kafka ${version} to ${root}"
echo -e "\n>>>>>>>>> download kafka"
mkdir -p ${root}
wget -O ${root}/kafka_2.12-${version}.tgz http://mirrors.tuna.tsinghua.edu.cn/apache/kafka/${version}/kafka_2.12-${version}.tgz

echo -e "\n>>>>>>>>> install kafka"
tar zxf ${root}/kafka_2.12-${version}.tgz -C ${root}
