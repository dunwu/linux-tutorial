#!/usr/bin/env bash

cat << EOF

###################################################################################
# 安装 Tomcat 脚本
# @system: 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

EOF

version=8.5.28
if [[ -n $1 ]]; then
  version=$1
fi

root=/opt/tomcat
if [[ -n $2 ]]; then
  root=$2
fi

echo -e "\n>>>>>>>>> download tomcat"
mkdir -p ${root}
wget -O ${root}/apache-tomcat-${version}.tar.gz https://archive.apache.org/dist/tomcat/tomcat-8/v${version}/bin/apache-tomcat-${version}.tar.gz

echo -e "\n>>>>>>>>> install tomcat"
tar zxvf ${root}/apache-tomcat-${version}.tar.gz -C ${root}
