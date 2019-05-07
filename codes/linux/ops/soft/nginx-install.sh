#!/usr/bin/env bash

cat << EOF

###################################################################################
# 安装 nginx 脚本
# nginx 会被安装到 /opt/nginx 路径。
# 注意：安装 nginx 需要依赖以下库，需预先安装：
# zlib zlib-devel gcc-c++ libtool openssl openssl-devel
# @system: 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

EOF

version=1.12.2
if [[ -n $1 ]]; then
  version=$1
fi

root=/opt/nginx
if [[ -n $2 ]]; then
  root=$2
fi

echo -e "\n>>>>>>>>> install libs"
yum install -y zlib zlib-devel gcc-c++ libtool openssl openssl-devel

# 首先要安装 PCRE，PCRE 作用是让 nginx 支持 Rewrite 功能
curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/pcre-install.sh | bash

echo -e "\n>>>>>>>>> download nginx"
mkdir -p ${root}
wget -O ${root}/nginx-${version}.tar.gz http://nginx.org/download/nginx-${version}.tar.gz

# 编译
tar zxf ${root}/nginx-${version}.tar.gz -C ${root}
cd ${root}/nginx-${version}
./configure --with-http_stub_status_module --with-http_ssl_module --with-pcre=${pcreRoot}/pcre-${pcreVersion}
nginx -v
cd -
