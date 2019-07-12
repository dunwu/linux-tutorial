#!/usr/bin/env bash

###################################################################################
# 安装 sonatype nexus(用于搭建 maven 私服) 脚本
# @system: 适用于所有 linux 发行版本。
# sonatype nexus 会被安装到 /opt/maven 路径。
# 注意：sonatype nexus 要求必须先安装 JDK
# @author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install sonatype nexus"

mkdir -p /opt/maven
cd /opt/maven

version=3.13.0-01
curl -o /opt/maven/nexus-unix.tar.gz http://download.sonatype.com/nexus/3/nexus-${version}-unix.tar.gz
tar -zxf nexus-unix.tar.gz
