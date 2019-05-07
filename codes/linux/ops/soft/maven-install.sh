#!/usr/bin/env bash

cat << EOF
###################################################################################
# 安装 Maven3 脚本
# 适用于所有 linux 发行版本。
# Maven 会被安装到 /opt/maven 路径。
# 注意：Maven 要求必须先安装 JDK
# Author: Zhang Peng
###################################################################################
EOF

version=3.6.0
if [[ -n $1 ]]; then
  version=$1
fi

root=/opt/maven
if [[ -n $2 ]]; then
  root=$2
fi

echo -e "\n>>>>>>>>> download maven"
mkdir -p ${root}
cd ${root}

wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  -O ${root}/apache-maven-${version}-bin.tar.gz http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/${version}/binaries/apache-maven-${version}-bin.tar.gz

echo -e "\n>>>>>>>>> install maven"
tar -zxvf apache-maven-${version}-bin.tar.gz -C ${root}

# 设置环境变量
cat >> /etc/profile << EOF
export MAVEN_HOME=/opt/maven/apache-maven-3.5.4
export PATH=\$MAVEN_HOME/bin:\$PATH
EOF
source /etc/profile

# 备份并替换 settings.xml，使用 aliyun 镜像加速 maven
echo -e "\n>>>>>>>>> replace /opt/maven/apache-maven-${version}/conf/settings.xml"
cp /opt/maven/apache-maven-${version}/conf/settings.xml /opt/maven/apache-maven-${version}/conf/settings.xml.bak
wget -N https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/config/settings-aliyun.xml -O /opt/maven/apache-maven-${version}/conf/settings.xml
