#!/usr/bin/env bash

cat << EOF

###################################################################################
# 安装 pcre 脚本
# @system: 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

EOF

version=8.35
if [[ -n $1 ]]; then
  version=$1
fi

root=/opt/pcre
if [[ -n $2 ]]; then
  root=$2
fi

echo -e "\n>>>>>>>>> donwload pcre"
mkdir -p ${root}
wget -O ${root}/pcre-${version}.tar.gz http://downloads.sourceforge.net/project/pcre/pcre/${version}/pcre-${version}.tar.gz

echo -e "\n>>>>>>>>> install pcre"
tar zxf ${root}/pcre-${version}.tar.gz -C ${root}
cd ${root}/pcre-${version}
./configure
make && make install
pcre-config --version
cd -
