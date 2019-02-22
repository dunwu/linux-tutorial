#!/usr/bin/env bash

###################################################################################
# 安装 Gitlab 脚本
# 仅适用于 CentOS7 发行版本
# Author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install gitlab"

echo -e "\n>>>>>>>>> 安装和配置必要依赖"
sudo yum install -y curl policycoreutils-python openssh-server
sudo systemctl enable sshd
sudo systemctl start sshd
sudo firewall-cmd --permanent --add-service=http
sudo systemctl reload firewalld

echo -e "\n>>>>>>>>> 安装和配置邮件服务"
sudo yum install postfix
sudo systemctl enable postfix
sudo systemctl start postfix

echo -e "\n>>>>>>>>> 通过 yum 安装 gitlab"
curl -o- https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash
sudo EXTERNAL_URL="http://gitlab.example.com" yum install -y gitlab-ce
