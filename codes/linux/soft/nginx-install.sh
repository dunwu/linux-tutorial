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

printf "${BLUE}\n"
cat << EOF
###################################################################################
# 采用编译方式安装 Nginx, 并将其注册为 systemd 服务
# 默认下载安装 1.16.0 版本，安装路径为：/usr/local/nginx
# @system: 适用于 CentOS7+
# @author: Zhang Peng
###################################################################################
EOF
printf "${RESET}\n"

command -v yum > /dev/null 2>&1 || {
	printf "${RED}Require yum but it's not installed.${RESET}\n";
	exit 1;
}

printf "\n${GREEN}>>>>>>>> install nginx begin${RESET}\n"

if [[ $# -lt 1 ]] || [[ $# -lt 2 ]]; then
	printf "${PURPLE}[Hint]\n"
	printf "\t Usage: sh nginx-install.sh [version] \n"
	printf "\t Default: sh nginx-install.sh 1.16.0 \n"
	printf "\t Example: sh nginx-install.sh 1.16.0 \n"
	printf "${RESET}\n"
fi

temp=/opt/nginx
version=1.16.0
if [[ -n $1 ]]; then
	version=$1
fi

# install info
printf "${PURPLE}[Install Info]\n"
printf "\t version = ${version}\n"
printf "${RESET}\n"

printf "${CYAN}>>>> install required libs${RESET}\n"
yum install -y zlib zlib-devel gcc-c++ libtool openssl openssl-devel pcre

# download and decompression
printf "${CYAN}>>>> download nginx${RESET}\n"
mkdir -p ${temp}
curl -o ${temp}/nginx-${version}.tar.gz http://nginx.org/download/nginx-${version}.tar.gz
tar zxf ${temp}/nginx-${version}.tar.gz -C ${temp}

# configure and makefile
printf "${CYAN}>>>> compile nginx${RESET}\n"
cd ${temp}/nginx-${version}
./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-pcre
make && make install
rm -rf ${temp}
cd -

# setting systemd service
printf "${CYAN}>>>> set nginx as a systemd service${RESET}\n"
wget -N https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/config/nginx/nginx.service -O /usr/lib/systemd/system/nginx.service
chmod +x /usr/lib/systemd/system/nginx.service

# boot nginx
printf "${CYAN}>>>> start nginx${RESET}\n"
systemctl enable nginx.service
systemctl start nginx.service

printf "\n${GREEN}<<<<<<<< install nginx end${RESET}\n"
printf "\n${PURPLE}nginx service status: ${RESET}\n"
systemctl status nginx
