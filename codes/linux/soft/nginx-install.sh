#!/usr/bin/env bash

###################################################################################
# 控制台颜色
BLACK="\033[1;30m"
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
PURPLE="\033[1;35m"
CYAN="\033[1;36m"
RESET="$(tput sgr0)"
###################################################################################

printf "${BLUE}"
cat << EOF

###################################################################################
# 采用编译方式安装 nginx 脚本
# nginx 会被安装到 /usr/local/nginx 路径。
# @system: 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

EOF
printf "${RESET}"

printf "${GREEN}>>>>>>>> install maven begin.${RESET}\n"

command -v yum >/dev/null 2>&1 || { printf "${RED}Require yum but it's not installed.${RESET}\n"; exit 1; }

if [[ $# -lt 1 ]] || [[ $# -lt 2 ]];then
  printf "${PURPLE}[Hint]\n"
  printf "\t sh nginx-install.sh [version] [path]\n"
  printf "\t Example: sh nginx-install.sh 1.16.0 /opt/nginx\n"
  printf "${RESET}\n"
fi

version=1.16.0
if [[ -n $1 ]]; then
  version=$1
fi

path=/opt/nginx
if [[ -n $2 ]]; then
  path=$2
fi

# install info
printf "${PURPLE}[Info]\n"
printf "\t version = ${version}\n"
printf "\t path = ${path}\n"
printf "${RESET}\n"

printf "${GREEN}>>>>>>>> install required libs.${RESET}\n"
yum install -y zlib zlib-devel gcc-c++ libtool openssl openssl-devel pcre

# download and decompression
mkdir -p ${path}
curl -o ${path}/nginx-${version}.tar.gz http://nginx.org/download/nginx-${version}.tar.gz
tar zxf ${path}/nginx-${version}.tar.gz -C ${path}

# configure and makefile
cd ${path}/nginx-${version}
./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-pcre
make && make install

# setting service
wget -N https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/config/nginx/nginx.service -O /usr/lib/systemd/system/nginx.service
chmod +x /usr/lib/systemd/system/nginx.service
#设置nginx.service为系统服务
systemctl enable nginx.service
##通过系统服务操作nginx
systemctl start nginx.service
#systemctl reload nginx.service
#systemctl restart nginx.service
#systemctl stop nginx.service
printf "${GREEN}<<<<<<<< install nginx end.${RESET}\n"
