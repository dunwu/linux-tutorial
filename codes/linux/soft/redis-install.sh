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
##########################################################################cd#########

printf "${BLUE}\n"
cat << EOF
###################################################################################
# 采用编译方式安装 Redis
# @system: 适用于 CentOS7+
# @author: Zhang Peng
###################################################################################
EOF
printf "${RESET}\n"

command -v yum > /dev/null 2>&1 || {
	printf "${RED}Require yum but it's not installed.${RESET}\n";
	exit 1;
}

printf "\n${GREEN}>>>>>>>> install redis begin${RESET}\n"

if [[ $# -lt 1 ]] || [[ $# -lt 2 ]] || [[ $# -lt 3 ]] || [[ $# -lt 4 ]]; then
	printf "${PURPLE}[Hint]\n"
	printf "\t Usage: sh redis-install.sh [version] [port] [password] \n"
	printf "\t Default: sh redis-install.sh 5.0.4 6379 <null> \n"
	printf "\t Example: sh redis-install.sh 5.0.4 6379 123456 \n"
	printf "${RESET}\n"
fi

version=5.0.4
if [[ -n $1 ]]; then
	version=$1
fi

port=6379
if [[ -n $2 ]]; then
	port=$2
fi

password=
if [[ -n $3 ]]; then
	password=$3
fi

# install info
printf "${PURPLE}[Install Info]\n"
printf "\t version = ${version}\n"
printf "\t port = ${port}\n"
printf "\t password = ${password}\n"
printf "${RESET}\n"

printf "${CYAN}>>>> install required libs${RESET}\n"
yum install -y zlib zlib-devel gcc-c++ libtool openssl openssl-devel tcl

# download and decompression
printf "${CYAN}>>>> download redis${RESET}\n"
temp="/tmp/redis"
path="/usr/local/redis"
mkdir -p ${temp}
curl -o ${temp}/redis-${version}.tar.gz http://download.redis.io/releases/redis-${version}.tar.gz
tar zxf ${temp}/redis-${version}.tar.gz -C ${temp}
mv ${temp}/redis-${version} ${path}

# configure and makefile
printf "${CYAN}>>>> compile redis${RESET}\n"
cd ${path}
make && make install
rm -rf ${temp}
cd -

printf "${CYAN}>>>> modify redis config${RESET}\n"
cp ${path}/redis.conf ${path}/redis.conf.default
wget -N https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/config/redis/redis.conf -O ${path}/redis.conf
sed -i "s/^port 6379/port ${port}/g" ${path}/redis.conf
if [[ -n ${password} ]]; then
	sed -i "s/^protected-mode no/protected-mode yes/g" ${path}/redis.conf
	sed -i "s/^# requirepass/requirepass ${password}/g" ${path}/redis.conf
fi

printf "\n${CYAN}>>>> open redis port in firewall${RESET}\n"
firewall-cmd --zone=public --add-port=${port}/tcp --permanent
firewall-cmd --reload

# setting systemd service
printf "${CYAN}>>>> set redis as a systemd service${RESET}\n"
wget -N https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/config/redis/redis.service -O /usr/lib/systemd/system/redis.service
chmod +x /usr/lib/systemd/system/redis.service

# boot redis
printf "${CYAN}>>>> start redis${RESET}\n"
systemctl enable redis.service
systemctl start redis.service

printf "\n${GREEN}<<<<<<<< install redis end${RESET}\n"
printf "\n${PURPLE}redis service status: ${RESET}\n"
systemctl status redis
