#!/usr/bin/env bash

cat << EOF

###################################################################################
# 安装 rocketmq 脚本
# @system: 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

EOF

version=4.5.0
if [[ -n $1 ]]; then
  version=$1
fi

root=/opt/rocketmq
if [[ -n $2 ]]; then
  root=$2
fi

echo -e "\n>>>>>>>>> download rocketmq"
mkdir -p ${root}
wget -O ${root}/rocketmq-all-${version}-bin-release.zip http://mirrors.tuna.tsinghua.edu.cn/apache/rocketmq/${version}/rocketmq-all-${version}-bin-release.zip

echo -e "\n>>>>>>>>> install rocketmq"
unzip -o ${root}/rocketmq-all-${version}-bin-release.zip -d ${root}/rocketmq-all-${version}/
