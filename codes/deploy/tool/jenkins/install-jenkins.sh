#!/usr/bin/env bash

###################################################################################
# 安装 Jenkins 脚本
# 适用于所有 linux 发行版本。
# Author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install jenkins"

# 下载并解压 jenkins
mkdir -p /opt/jenkins
wget -O /opt/jenkins/jenkins.war http://mirrors.jenkins.io/war-stable/latest/jenkins.war
