#!/usr/bin/env bash

###################################################################################
# 安装 nginx 脚本
# 仅适用于 CentOS 发行版本。
# @author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install nginx"

# Centos7 rpm 地址：http://nginx.org/packages/rhel/7/x86_64/RPMS/
# CentOS6 rpm 地址：http://nginx.org/packages/rhel/6/x86_64/RPMS/

mkdir -p /opt/nginx
curl -o /opt/nginx/nginx.rpm http://nginx.org/packages/rhel/7/x86_64/RPMS/nginx-1.14.0-1.el7_4.ngx.x86_64.rpm
rpm -ivh /opt/nginx/nginx.rpm
nginx -v
