#!/usr/bin/env bash

cat << EOF

###################################################################################
# 安装 JDK8 脚本
# 仅适用于所有 CentOS 发行版本
# JDK 会被安装到 /usr/lib/jvm/java 路径。
# Author: Zhang Peng
###################################################################################

EOF

echo -e "\n>>>>>>>>> install jdk8"

yum -y install java-1.8.0-openjdk.x86_64
yum -y install java-1.8.0-openjdk-devel.x86_64
java -version
