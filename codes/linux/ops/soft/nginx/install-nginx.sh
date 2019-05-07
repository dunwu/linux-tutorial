#!/usr/bin/env bash

###################################################################################
# 安装 nginx 脚本
# 适用于所有 linux 发行版本。
# nginx 会被安装到 /opt/nginx 路径。
# 注意：安装 nginx 需要依赖以下库，需预先安装：
# zlib zlib-devel gcc-c++ libtool openssl openssl-devel
# @author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install nginx"

# 首先要安装 PCRE，PCRE 作用是让 nginx 支持 Rewrite 功能
pcreRoot=/opt/pcre
pcreVersion=8.35
install-pcre.sh ${pcreRoot} ${pcreVersion}

# 下载并解压 nginx
ngixnRoot=/opt/nginx
nginxVersion=1.12.2
mkdir -p ${ngixnRoot}
wget -O ${ngixnRoot}/nginx-${nginxVersion}.tar.gz http://nginx.org/download/nginx-${nginxVersion}.tar.gz
cd ${ngixnRoot}
tar zxvf nginx-${nginxVersion}.tar.gz

# 编译
cd nginx-${nginxVersion}
./configure --with-http_stub_status_module --with-http_ssl_module --with-pcre=${pcreRoot}/pcre-${pcreVersion}
nginx -v
