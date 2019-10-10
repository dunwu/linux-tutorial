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
# 安装 Redis 脚本
# @system: 适用于 CentOS
# @author: Zhang Peng
###################################################################################

EOF
printf "${RESET}"

command -v yum > /dev/null 2>&1 || { printf "${RED}Require yum but it's not installed.${RESET}\n";
    exit 1; }

if [[ $# -lt 1 ]] || [[ $# -lt 2 ]] || [[ $# -lt 3 ]] || [[ $# -lt 4 ]]; then
    echo "Usage: sh redis-install.sh [version] [path] [port] [password]"
    echo -e "Example: sh redis-install.sh 5.0.4 /opt/redis 6379 123456\n"
fi

version=5.0.4
if [[ -n $1 ]]; then
    version=$1
fi

root=/opt/redis
if [[ -n $2 ]]; then
    root=$2
fi

port=6379
if [[ -n $3 ]]; then
    port=$3
fi

password=
if [[ -n $4 ]]; then
    password=$4
fi

printf "${GREEN}>>>>>>>> install redis begin.${RESET}\n"

printf "\t${GREEN}Current execution: install redis ${version} to ${root}, service port = ${port}, password = ${password}${RESET}\n"
yum install -y zlib zlib-devel gcc-c++ libtool openssl openssl-devel tcl

mkdir -p ${root}
curl -o ${root}/redis-${version}.tar.gz http://download.redis.io/releases/redis-${version}.tar.gz

path=${root}/redis-${version}
tar zxf ${root}/redis-${version}.tar.gz -C ${root}
cd ${path}
make && make install
cd -

printf "\n${CYAN}>>>>>>>>> config redis${RESET}\n"
cp ${path}/redis.conf ${path}/redis.conf.default
wget -N https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/config/redis-remote-access.conf -O ${path}/redis.conf
mkdir -p /etc/redis
cp ${path}/redis.conf /etc/redis/${port}.conf
sed -i "s/^port 6379/port ${port}/g" /etc/redis/${port}.conf
if [[ -n ${password} ]]; then
    sed -i "s/^# requirepass/requirepass ${password}/g" /etc/redis/${port}.conf
fi

printf "\n${CYAN}>>>>>>>>> add firewall port${RESET}\n"
firewall-cmd --zone=public --add-port=${port}/tcp --permanent
firewall-cmd --reload

printf "\n${CYAN}>>>>>>>>> add redis service${RESET}\n"
# 注册 redis 服务，并设置开机自启动
cp ${path}/utils/redis_init_script /etc/init.d/
mv /etc/init.d/redis_init_script /etc/init.d/redis_${port}
sed -i "s/^REDISPORT=.*/REDISPORT=${port}/g" /etc/init.d/redis_${port}
chmod +x /etc/init.d/redis_${port}
chkconfig --add redis_${port}
service redis_${port} start

printf "\n${GREEN}<<<<<<<< install redis end.${RESET}\n"
