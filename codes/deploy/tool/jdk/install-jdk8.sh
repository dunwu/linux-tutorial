#!/usr/bin/env bash

###################################################################################
# 安装 JDK8 脚本
# 适用于所有 linux 发行版本。
# JDK 会被安装到 /opt/software/java/jdk1.8.0_162 路径。
# Author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install jdk8"

mkdir -p /opt/software/java
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" -O /opt/software/java/jdk-8u162-linux-x64.tar.gz  http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-x64.tar.gz

cd /opt/software/java
tar -zxvf jdk-8u162-linux-x64.tar.gz

cat >> /etc/profile << EOF

export JAVA_HOME=/opt/software/java/jdk1.8.0_162
export PATH=\$JAVA_HOME/bin:\$PATH
export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar
EOF
source /etc/profile
