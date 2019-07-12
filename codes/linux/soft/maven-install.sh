#!/usr/bin/env bash

cat << EOF
###################################################################################
# 安装 Maven3 脚本
# Maven 会被安装到 /opt/maven 路径。
# @system: 适用于所有 linux 发行版本。
# 注意：Maven 要求必须先安装 JDK
# @author: Zhang Peng
###################################################################################
EOF

command -v java >/dev/null 2>&1 || { echo >&2 "Require java but it's not installed."; exit 1; }

if [[ $# -lt 1 ]] || [[ $# -lt 2 ]];then
    echo "Usage: sh maven-install.sh [version] [path]"
    echo -e "Example: sh maven-install.sh 3.6.0 /opt/maven\n"
fi

version=3.6.0
if [[ -n $1 ]]; then
  version=$1
fi

root=/opt/maven
if [[ -n $2 ]]; then
  root=$2
fi

echo "Current execution: install maven ${version} to ${root}"

echo -e "\n>>>>>>>>> download maven"
mkdir -p ${root}
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" -O ${root}/apache-maven-${version}-bin.tar.gz http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/${version}/binaries/apache-maven-${version}-bin.tar.gz

echo -e "\n>>>>>>>>> install maven"
tar -zxvf ${root}/apache-maven-${version}-bin.tar.gz -C ${root}

path=${root}/apache-maven-${version}
# 设置环境变量
cat >> /etc/profile << EOF
export MAVEN_HOME=${path}
export PATH=\$MAVEN_HOME/bin:\$PATH
EOF
source /etc/profile

# 备份并替换 settings.xml，使用 aliyun 镜像加速 maven
echo -e "\n>>>>>>>>> replace ${path}/conf/settings.xml"
cp ${path}/conf/settings.xml ${path}/conf/settings.xml.bak
wget -N https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/config/settings-aliyun.xml -O ${path}/conf/settings.xml

mvn -v
