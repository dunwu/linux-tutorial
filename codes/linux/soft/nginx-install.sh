#!/usr/bin/env bash

cat << EOF

###################################################################################
# 安装 nginx 脚本
# nginx 会被安装到 /opt/nginx 路径。
# @system: 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

EOF

command -v yum >/dev/null 2>&1 || { echo >&2 "Require yum but it's not installed.  Aborting."; exit 1; }

if [[ $# -lt 1 ]] || [[ $# -lt 2 ]];then
    echo "Usage: sh nginx-install.sh [version] [path]"
    echo -e "Example: sh nginx-install.sh 1.16.0 /opt/nginx\n"
fi

version=1.16.0
if [[ -n $1 ]]; then
  version=$1
fi

root=/opt/nginx
if [[ -n $2 ]]; then
  root=$2
fi

echo "Current execution: install nginx ${version} to ${root}"
echo -e "\n>>>>>>>>> install libs"
yum install -y zlib zlib-devel gcc-c++ libtool openssl openssl-devel pcre

echo -e "\n>>>>>>>>> download nginx"
mkdir -p ${root}
wget -O ${root}/nginx-${version}.tar.gz http://nginx.org/download/nginx-${version}.tar.gz

# 编译
tar zxf ${root}/nginx-${version}.tar.gz -C ${root}
cd ${root}/nginx-${version}
./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-pcre
make && make install
/usr/local/nginx/sbin/nginx -v
cd -
