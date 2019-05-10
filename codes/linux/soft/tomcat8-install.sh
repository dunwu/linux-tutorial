#!/usr/bin/env bash

cat << EOF

###################################################################################
# 安装 Tomcat 脚本
# @system: 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

EOF

if [[ $# -lt 1 ]] || [[ $# -lt 2 ]];then
    echo "Usage: sh tomcat8-install.sh [version] [path]"
    echo -e "Example: sh tomcat8-install.sh 8.5.28 /opt/tomcat8\n"
fi

version=8.5.28
if [[ -n $1 ]]; then
  version=$1
fi

root=/opt/tomcat
if [[ -n $2 ]]; then
  root=$2
fi

echo "Current execution: install tomcat8 ${version} to ${root}"
echo -e "\n>>>>>>>>> download tomcat"
mkdir -p ${root}
wget -O ${root}/apache-tomcat-${version}.tar.gz https://archive.apache.org/dist/tomcat/tomcat-8/v${version}/bin/apache-tomcat-${version}.tar.gz

echo -e "\n>>>>>>>>> install tomcat"
tar zxf ${root}/apache-tomcat-${version}.tar.gz -C ${root}
