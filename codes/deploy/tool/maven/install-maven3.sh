#!/usr/bin/env bash

echo -e "\n>>>>>>>>> install maven"

mkdir -p /opt/software/maven
cd /opt/software/maven

version=3.5.2
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/${version}/binaries/apache-maven-${version}-bin.tar.gz
tar -zxvf apache-maven-${version}-bin.tar.gz

cat >> /etc/profile << EOF
MAVEN_HOME=/opt/software/maven/apache-maven-\${version}
PATH=\${MAVEN_HOME}/bin:\${PATH}
export MAVEN_HOME
export PATH
EOF
source /etc/profile
