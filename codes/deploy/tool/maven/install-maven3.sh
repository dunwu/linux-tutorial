#!/usr/bin/env bash

###################################################################################
# 安装 Maven 脚本
# 适用于所有 linux 发行版本。
# Maven 会被安装到 /opt/software/maven 路径。
# 注意：Maven 要求必须先安装 JDK
# Author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install maven"

mkdir -p /opt/software/maven
cd /opt/software/maven

version=3.2.5
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/${version}/binaries/apache-maven-${version}-bin.tar.gz
tar -zxvf apache-maven-${version}-bin.tar.gz

cat >> /etc/profile << EOF
export MAVEN_HOME=/opt/software/maven/apache-maven-${version}
export PATH=\$MAVEN_HOME/bin:\$PATH
EOF
source /etc/profile
