#!/usr/bin/env bash

###################################################################################
# 安装 pcre 脚本
# 适用于所有 linux 发行版本。
# 注意：本脚本需输入根路径和版本号两个参数。
# @author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install pcre"

root=$1
version=$2

# 下载并解压 pcre
mkdir -p ${root}
wget -O ${root}/pcre-${version}.tar.gz http://downloads.sourceforge.net/project/pcre/pcre/${version}/pcre-${version}.tar.gz
cd ${root}
tar zxf pcre-${version}.tar.gz
cd pcre-${version}

# 编译
./configure
make && make install
pcre-config --version
