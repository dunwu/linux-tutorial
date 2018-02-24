#!/usr/bin/env bash

###################################################################################
# 安装 Tomcat 脚本
# 适用于所有 linux 发行版本。
# Author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install tomcat"

# 下载并解压 redis
root=/opt/software/tomcat
version=8.5.28
mkdir -p ${root}
wget -O ${root}/apache-tomcat-${version}.tar.gz http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v${version}/bin/apache-tomcat-${version}.tar.gz
cd ${root}
tar zxvf apache-tomcat-${version}.tar.gz
