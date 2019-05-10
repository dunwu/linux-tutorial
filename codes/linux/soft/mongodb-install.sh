#!/usr/bin/env bash

cat << EOF

###################################################################################
# 安装 mongodb 脚本
# @system: 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

EOF

if [[ $# -lt 1 ]] || [[ $# -lt 2 ]];then
    echo "Usage: sh mongodb-install.sh [version] [path]"
    echo -e "Example: sh mongodb-install.sh 4.0.9 /opt/mongodb\n"
fi

version=4.0.9
if [[ -n $1 ]]; then
  version=$1
fi

root=/opt/mongodb
if [[ -n $2 ]]; then
  root=$2
fi

echo "Current execution: install mongodb ${version} to ${root}"

echo -e "\n>>>>>>>>> download mongodb"
mkdir -p ${root}
wget -O ${root}/mongodb-linux-x86_64-${version}.tgz https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-${version}.tgz

echo -e "\n>>>>>>>>> install mongodb"
tar zxf ${root}/mongodb-linux-x86_64-${version}.tgz -C ${root}
mkdir -p /data/db
