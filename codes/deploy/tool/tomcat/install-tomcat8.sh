#!/usr/bin/env bash

###################################################################################
# 安装 Tomcat 脚本
# 适用于所有 linux 发行版本。
# Author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install tomcat"

# 下载并解压 redis
root=/opt/tomcat
version=8.5.28
mkdir -p ${root}
wget -O ${root}/apache-tomcat-${version}.tar.gz https://archive.apache.org/dist/tomcat/tomcat-8/v${version}/bin/apache-tomcat-${version}.tar.gz
tar zxvf apache-tomcat-${version}.tar.gz
