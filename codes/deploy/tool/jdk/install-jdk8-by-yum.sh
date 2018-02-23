#!/usr/bin/env bash

###################################################################################
# 安装 JDK8 脚本
# 仅适用于所有 Centos 发行版本
# JDK 会被安装到 /usr/lib/jvm/java 路径。
# Author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install jdk8"

yum -y install java-1.8.0-openjdk-devel-debug.x86_64

cat >> /etc/profile << EOF

export JAVA_HOME=/usr/lib/jvm/java
export PATH=\$JAVA_HOME/bin:\$PATH
export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar
EOF
source /etc/profile
