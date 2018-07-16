#!/usr/bin/env bash

###################################################################################
# 安装 rocketmq 脚本
# 适用于所有 linux 发行版本。
# Author: Zhang Peng
###################################################################################

# 下载并解压 rocketmq
echo -e "\n>>>>>>>>> install rocketmq"

root=/opt/software/rocketmq
version=4.2.0
mkdir -p ${root}
wget -O ${root}/rocketmq-all-${version}-bin-release.zip http://mirrors.hust.edu.cn/apache/rocketmq/${version}/rocketmq-all-${version}-bin-release.zip
cd ${root}
unzip -o rocketmq-all-${version}-bin-release.zip -d rocketmq-all-${version}/
