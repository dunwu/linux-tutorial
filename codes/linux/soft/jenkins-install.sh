#!/usr/bin/env bash

###################################################################################
# 安装 Jenkins 脚本
# 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install jenkins"

# 下载并解压 jenkins
mkdir -p /opt/jenkins
curl -o /opt/jenkins/jenkins.war http://mirrors.jenkins.io/war-stable/latest/jenkins.war
