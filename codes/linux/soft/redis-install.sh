#!/usr/bin/env bash

cat << EOF

###################################################################################
# 安装 Redis 脚本
# @system: 适用于 CentOS
# @author: Zhang Peng
###################################################################################

EOF

command -v yum >/dev/null 2>&1 || { printf "${RED}Require yum but it's not installed.${RESET}\n"; exit 1; }

if [[ $# -lt 1 ]] || [[ $# -lt 2 ]] || [[ $# -lt 3 ]] || [[ $# -lt 4 ]];then
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

echo "Current execution: install redis ${version} to ${root}, service port = ${port}, password = ${password}"
echo -e "\n>>>>>>>>> install libs"
yum install -y zlib zlib-devel gcc-c++ libtool openssl openssl-devel tcl

echo -e "\n>>>>>>>>> download redis"
mkdir -p ${root}
wget -O ${root}/redis-${version}.tar.gz http://download.redis.io/releases/redis-${version}.tar.gz

echo -e "\n>>>>>>>>> install redis"
path=${root}/redis-${version}
tar zxf ${root}/redis-${version}.tar.gz -C ${root}
cd ${path}
make && make install
cd -

echo -e "\n>>>>>>>>> config redis"
cp ${path}/redis.conf ${path}/redis.conf.default
wget -N https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/config/redis-remote-access.conf -O ${path}/redis.conf
cp ${path}/redis.conf /etc/redis/${port}.conf
sed -i "s/^port 6379/port ${port}/g" /etc/redis/${port}.conf
sed -i "s/^requirepass 123456/requirepass ${password}/g" /etc/redis/${port}.conf

echo -e "\n>>>>>>>>> add firewall port"
firewall-cmd --zone=public --add-port=${port}/tcp --permanent
firewall-cmd --reload

echo -e "\n>>>>>>>>> add redis service"
# 注册 redis 服务，并设置开机自启动
cp ${path}/utils/redis_init_script /etc/init.d/redis_${port}
sed -i "s/^REDISPORT=.*/REDISPORT=${port}/g" /etc/init.d/redis_${port}
chmod +x /etc/init.d/redis_${port}
chkconfig --add redis_${port}
service redis_${port} start

