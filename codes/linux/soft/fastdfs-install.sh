#!/usr/bin/env bash

##############################################################################
# console color
BLACK="\033[1;30m"
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
PURPLE="\033[1;35m"
CYAN="\033[1;36m"
RESET="$(tput sgr0)"
##############################################################################

printf "${PURPLE}"
cat << EOF

###################################################################################
# 安装 FastDFS 脚本
# FastDFS 会被安装到 /opt/fdfs 路径。
# @system: 适用于 CentOS
# @author: Zhang Peng
###################################################################################

EOF
printf "${RESET}"

command -v yum >/dev/null 2>&1 || { echo >&2 -e "${RED}Require yum but it's not installed. Aborting.${RESET}"; exit 1; }
command -v git >/dev/null 2>&1 || { echo >&2 -e "${RED}Require git but it's not installed. Aborting.${RESET}"; exit 1; }

yum install git gcc gcc-c++ make automake autoconf libtool pcre pcre-devel zlib zlib-devel openssl-devel wget vim -y

root=/opt/fdfs
if [[ -n $1 ]]; then
  root=$1
fi

version=1.16.0
if [[ -n $2 ]]; then
  version=$2
fi

nginx_path=/opt/nginx
if [[ -n $3 ]]; then
  root=$3
fi

mkdir -p ${root}

echo -e "\n${GREEN}>>>>>>>>> 安装 libfastcommon${RESET}"
mkdir -p ${root}/libfastcommon
git clone https://github.com/happyfish100/libfastcommon.git "${root}/libfastcommon"
cd ${root}/libfastcommon
./make.sh && ./make.sh install

echo -e "\n${GREEN}>>>>>>>>> 安装 fastdfs${RESET}"
mkdir -p ${root}/fastdfs
git clone https://github.com/happyfish100/fastdfs.git "${root}/fastdfs"
cd ${root}/fastdfs
./make.sh && ./make.sh install

echo -e "\n${GREEN}>>>>>>>>> 安装 fastdfs-nginx-module${RESET}"
mkdir -p ${root}/fastdfs-nginx-module
git clone https://github.com/happyfish100/fastdfs-nginx-module.git "${root}/fastdfs-nginx-module"

echo -e "\n${GREEN}>>>>>>>>> 安装 nginx${RESET}"
mkdir -p ${nginx_path}
wget -O ${nginx_path}/nginx-${version}.tar.gz http://nginx.org/download/nginx-${version}.tar.gz
tar zxf ${nginx_path}/nginx-${version}.tar.gz -C ${nginx_path}
cd ${nginx_path}/nginx-${version}
./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-pcre --add-module=${root}/fastdfs-nginx-module/src/
make && make install

echo -e "\n${GREEN}>>>>>>>>> fastdfs 配置文件准备${RESET}"
# 配置修改参考：https://github.com/happyfish100/fastdfs/wiki

cp ${root}/fastdfs/conf/http.conf /etc/fdfs/ #供nginx访问使用
cp ${root}/fastdfs/conf/mime.types /etc/fdfs/ #供nginx访问使用
cp ${root}/fastdfs-nginx-module/src/mod_fastdfs.conf /etc/fdfs
wget -N https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/soft/config/fastdfs/tracker.conf -O /etc/fdfs/tracker.conf
wget -N https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/soft/config/fastdfs/storage.conf -O /etc/fdfs/storage.conf
wget -N https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/soft/config/fastdfs/client.conf -O /etc/fdfs/client.conf
# fdfs 存储路径和服务端口（以默认形式配置）
fdfs_store_path=/home/fdfs
fdfs_server_port=7001
ip=$(ip addr | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}')
echo -e "\n${GREEN} - 修改 tracker.conf 配置${RESET}"
sed -i "s#^base_path=.*#base_path=${fdfs_store_path}#g" /etc/fdfs/tracker.conf
echo -e "\n${GREEN} - 修改 storage.conf 配置${RESET}"
sed -i "s#^base_path=.*#base_path=${fdfs_store_path}#g" /etc/fdfs/storage.conf
sed -i "s#^store_path0=.*#store_path0=${fdfs_store_path}#g" /etc/fdfs/storage.conf
sed -i "s#^tracker_server=.*#tracker_server=${ip}:22122#g" /etc/fdfs/storage.conf
sed -i "s#^http.server_port=.*#http.server_port=${fdfs_server_port}#g" /etc/fdfs/storage.conf
echo -e "\n${GREEN} - 修改 client.conf 配置${RESET}"
sed -i "s#^base_path=.*#base_path=${fdfs_store_path}#g" /etc/fdfs/client.conf
sed -i "s#^tracker_server=.*#tracker_server=${ip}:22122#g" /etc/fdfs/client.conf
echo -e "\n${GREEN} - 修改 mod_fastdfs.conf 配置${RESET}"
sed -i "s#^url_have_group_name=.*#url_have_group_name=true#g" /etc/fdfs/mod_fastdfs.conf
sed -i "s#^tracker_server=.*#tracker_server=${ip}:22122#g" /etc/fdfs/mod_fastdfs.conf
sed -i "s#^store_path0=.*#store_path0=${fdfs_store_path}#g" /etc/fdfs/mod_fastdfs.conf
echo -e "\n${GREEN} - 修改 nginx.conf 配置${RESET}\n"
mkdir -p /usr/local/nginx/conf/conf
wget -N https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/soft/config/nginx/nginx.conf -O /usr/local/nginx/conf/nginx.conf
wget -N https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/soft/config/nginx/conf/fdfs.conf -O /usr/local/nginx/conf/conf/fdfs.conf

echo -e "\n${GREEN}>>>>>>>>> 启动 fastdfs ${RESET}"
/etc/init.d/fdfs_trackerd start #启动tracker服务
#/etc/init.d/fdfs_trackerd restart #重启动tracker服务
#/etc/init.d/fdfs_trackerd stop #停止tracker服务
chkconfig fdfs_trackerd on #自启动tracker服务

/etc/init.d/fdfs_storaged start #启动storage服务
#/etc/init.d/fdfs_storaged restart #重动storage服务
#/etc/init.d/fdfs_storaged stop #停止动storage服务
chkconfig fdfs_storaged on #自启动storage服务

wget -N https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/soft/config/nginx/nginx.service -O /usr/lib/systemd/system/nginx.service
chmod +x /usr/lib/systemd/system/nginx.service
#设置nginx.service为系统服务
systemctl enable nginx.service
##通过系统服务操作nginx
systemctl start nginx.service
#systemctl reload nginx.service
#systemctl restart nginx.service
#systemctl stop nginx.service

echo -e "\n>>>>>>>>> add fastdfs port"
firewall-cmd --zone=public --add-port=${fdfs_server_port}/tcp --permanent
firewall-cmd --zone=public --add-port=22122/tcp --permanent
firewall-cmd --reload
