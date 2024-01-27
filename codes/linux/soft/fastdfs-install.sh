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
# install FastDFS 脚本
# FastDFS 会被install到 /opt/fdfs 路径。
# @system: 适用于 CentOS
# @author: Zhang Peng
# @ses: https://github.com/happyfish100/fastdfs/wiki
###################################################################################

EOF
printf "${RESET}"

printf "${GREEN}>>>>>>>> install fastdfs begin.${RESET}\n"

command -v yum > /dev/null 2>&1 || {
	printf "${RED}Require yum but it's not installed.${RESET}\n";
	exit 1;
}
command -v git > /dev/null 2>&1 || {
	printf "${RED}Require git but it's not installed.${RESET}\n";
	exit 1;
}

if [[ $# -lt 1 ]] || [[ $# -lt 2 ]]; then
	printf "${PURPLE}[Hint]\n"
	printf "\t sh fastdfs-install.sh [path]\n"
	printf "\t Example: sh fastdfs-install.sh /opt/fastdfs\n"
	printf "${RESET}\n"
fi

path=/opt/fdfs
if [[ -n $1 ]]; then
	path=$1
fi

nginx_version=1.16.0
nginx_path=/opt/nginx

printf "${GREEN}>>>>>>>> install required libs.${RESET}\n\n"
yum install -y git gcc gcc-c++ make automake autoconf libtool pcre pcre-devel zlib zlib-devel openssl-devel wget vim unzip

# download and decompression
mkdir -p ${path}
path=/opt/fdfs
mkdir -p ${path}/libfastcommon
curl -o ${path}/libfastcommon.zip http://dunwu.test.upcdn.net/soft/fdfs/libfastcommon.zip
if [[ ! -f ${path}/libfastcommon.zip ]]; then
	printf "${RED}[Error]install libfastcommon failed，exit. ${RESET}\n"
	exit 1
fi
unzip -o ${path}/libfastcommon.zip -d ${path}


cd ${path}/libfastcommon
chmod +x -R ${path}/libfastcommon/*.sh
./make.sh && ./make.sh install

printf "${GREEN}>>>>>>>>> install fastdfs${RESET}"
mkdir -p ${path}/fastdfs
curl -o ${path}/fastdfs.zip http://dunwu.test.upcdn.net/soft/fdfs/fastdfs.zip
if [[ ! -f ${path}/fastdfs.zip ]]; then
	printf "${RED}>>>>>>>>> install fastdfs failed，exit. ${RESET}\n"
fi
unzip -o ${path}/fastdfs.zip -d ${path}
cd ${path}/fastdfs
chmod +x -R ${path}/fastdfs/*.sh
./make.sh && ./make.sh install

printf "${GREEN}>>>>>>>>> install fastdfs-nginx-module${RESET}\n"
mkdir -p ${path}/fastdfs-nginx-module
curl -o ${path}/fastdfs-nginx-module.zip http://dunwu.test.upcdn.net/soft/fdfs/fastdfs-nginx-module.zip
if [[ ! -f ${path}/fastdfs-nginx-module.zip ]]; then
	printf "${RED}>>>>>>>>> install fastdfs-nginx-module failed，exit. ${RESET}\n"
fi
unzip -o ${path}/fastdfs-nginx-module.zip -d ${path}

printf "${GREEN}>>>>>>>>> install nginx${RESET}"
mkdir -p ${nginx_path}
curl -o ${nginx_path}/nginx-${nginx_version}.tar.gz http://nginx.org/download/nginx-${nginx_version}.tar.gz
tar zxf ${nginx_path}/nginx-${nginx_version}.tar.gz -C ${nginx_path}
cd ${nginx_path}/nginx-${nginx_version}
./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-pcre --add-module=${path}/fastdfs-nginx-module/src/
make && make install

printf "${GREEN}>>>>>>>>> fastdfs 配置文件准备${RESET}\n"
# 配置修改参考：https://github.com/happyfish100/fastdfs/wiki

mkdir -p /etc/fdfs
cp ${path}/fastdfs/conf/http.conf /etc/fdfs/ #供nginx访问使用
cp ${path}/fastdfs/conf/mime.types /etc/fdfs/ #供nginx访问使用
cp ${path}/fastdfs-nginx-module/src/mod_fastdfs.conf /etc/fdfs
wget -N https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/config/fastdfs/tracker.conf -O /etc/fdfs/tracker.conf
wget -N https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/config/fastdfs/storage.conf -O /etc/fdfs/storage.conf
wget -N https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/config/fastdfs/client.conf -O /etc/fdfs/client.conf
# fdfs 存储路径和服务端口（以默认形式配置）
fdfs_store_path=/home/fdfs
fdfs_server_port=7001
ip=$(ip addr | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}')

mkdir -p ${fdfs_store_path}
printf "${GREEN} - 修改 tracker.conf 配置${RESET}\n"
sed -i "s#^base_path=.*#base_path=${fdfs_store_path}#g" /etc/fdfs/tracker.conf
printf "${GREEN} - 修改 storage.conf 配置${RESET}\n"
sed -i "s#^base_path=.*#base_path=${fdfs_store_path}#g" /etc/fdfs/storage.conf
sed -i "s#^store_path0=.*#store_path0=${fdfs_store_path}#g" /etc/fdfs/storage.conf
sed -i "s#^tracker_server=.*#tracker_server=${ip}:22122#g" /etc/fdfs/storage.conf
sed -i "s#^http.server_port=.*#http.server_port=${fdfs_server_port}#g" /etc/fdfs/storage.conf
printf "${GREEN} - 修改 client.conf 配置${RESET}\n"
sed -i "s#^base_path=.*#base_path=${fdfs_store_path}#g" /etc/fdfs/client.conf
sed -i "s#^tracker_server=.*#tracker_server=${ip}:22122#g" /etc/fdfs/client.conf
printf "${GREEN} - 修改 mod_fastdfs.conf 配置${RESET}\n"
sed -i "s#^url_have_group_name=.*#url_have_group_name=true#g" /etc/fdfs/mod_fastdfs.conf
sed -i "s#^tracker_server=.*#tracker_server=${ip}:22122#g" /etc/fdfs/mod_fastdfs.conf
sed -i "s#^store_path0=.*#store_path0=${fdfs_store_path}#g" /etc/fdfs/mod_fastdfs.conf
printf "${GREEN} - 修改 nginx.conf 配置${RESET}\n"
mkdir -p /usr/local/nginx/conf/conf
wget -N https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/config/nginx/nginx.conf -O /usr/local/nginx/conf/nginx.conf
wget -N https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/config/nginx/conf/fdfs.conf -O /usr/local/nginx/conf/conf/fdfs.conf

printf "${GREEN}>>>>>>>>> 启动 fastdfs ${RESET}\n"
chmod +x /etc/init.d/fdfs_trackerd
/etc/init.d/fdfs_trackerd start #启动tracker服务
#/etc/init.d/fdfs_trackerd restart #重启动tracker服务
#/etc/init.d/fdfs_trackerd stop #停止tracker服务
chkconfig fdfs_trackerd on #自启动tracker服务

chmod +x /etc/init.d/fdfs_storaged
/etc/init.d/fdfs_storaged start #启动storage服务
#/etc/init.d/fdfs_storaged restart #重动storage服务
#/etc/init.d/fdfs_storaged stop #停止动storage服务
chkconfig fdfs_storaged on #自启动storage服务

wget -N https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/config/nginx/nginx.service -O /usr/lib/systemd/system/nginx.service
chmod +x /usr/lib/systemd/system/nginx.service
#设置nginx.service为系统服务
systemctl enable nginx.service
##通过系统服务操作nginx
systemctl start nginx.service
#systemctl reload nginx.service
#systemctl restart nginx.service
#systemctl stop nginx.service

printf ">>>>>>>>> add fastdfs port"
firewall-cmd --zone=public --add-port=${fdfs_server_port}/tcp --permanent
firewall-cmd --zone=public --add-port=22122/tcp --permanent
firewall-cmd --reload

printf "${GREEN}<<<<<<<< install fastdfs end.${RESET}\n"
#touch test.txt
#result=`fdfs_upload_file /etc/fdfs/client.conf test.txt`
#echo ${result}
#rm -f test.txt
