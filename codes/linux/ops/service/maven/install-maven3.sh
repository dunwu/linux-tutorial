#!/usr/bin/env bash

###################################################################################
# 安装 Maven 脚本
# 适用于所有 linux 发行版本。
# Maven 会被安装到 /opt/maven 路径。
# 注意：Maven 要求必须先安装 JDK
# Author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install maven"

mkdir -p /opt/maven
cd /opt/maven

version=3.5.4
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/${version}/binaries/apache-maven-${version}-bin.tar.gz
tar -zxvf apache-maven-${version}-bin.tar.gz

# 设置环境变量
cat >> /etc/profile << EOF
export MAVEN_HOME=/opt/maven/apache-maven-3.5.4
export PATH=\$MAVEN_HOME/bin:\$PATH
EOF
source /etc/profile

# 备份并替换 settings.xml，使用 aliyun 镜像加速 maven
echo -e "\n>>>>>>>>> replace /opt/maven/apache-maven-${version}/conf/settings.xml"
cp /opt/maven/apache-maven-${version}/conf/settings.xml /opt/maven/apache-maven-${version}/conf/settings.xml.bak
wget -N https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/service/maven/settings-aliyun.xml -O /opt/maven/apache-maven-${version}/conf/settings.xml

# 回到初始目录
cd -
