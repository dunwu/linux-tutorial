#!/usr/bin/env bash

# auth:kaliarch
# version:v1.0
# func:grafana 5.1.0/5.1.5/5.2.2 安装

# 定义安装目录、及日志信息
. /etc/init.d/functions
[ $(id -u) != "0" ] && echo "Error: You must be root to run this script" && exit 1
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
download_path=/tmp/tmpdir/
install_log_name=install_grafana.log
env_file=/etc/profile.d/grafana.sh
install_log_path=/var/log/appinstall/
install_path=/usr/local/

clear
echo "##########################################"
echo "#                                        #"
echo "#    安装  grafana 5.1.0/5.1.5/5.2.2     #"
echo "#                                        #"
echo "##########################################"
echo "1: Install grafana 5.1.0"
echo "2: Install grafana 5.1.5"
echo "3: Install grafana 5.2.2"
echo "4: EXIT"
# 选择安装软件版本
read -p "Please input your choice:" softversion
if [ "${softversion}" == "1" ]; then
	URL="https://anchnet-script.oss-cn-shanghai.aliyuncs.com/grafana/grafana-5.1.0-1.x86_64.rpm"
elif [ "${softversion}" == "2" ]; then
	URL="https://anchnet-script.oss-cn-shanghai.aliyuncs.com/grafana/grafana-5.1.5-1.x86_64.rpm"
elif [ "${softversion}" == "3" ]; then
	URL="https://anchnet-script.oss-cn-shanghai.aliyuncs.com/grafana/grafana-5.2.2-1.x86_64.rpm"
elif [ "${softversion}" == "4" ]; then
	echo "you choce channel!"
	exit 1;
else
	echo "input Error! Place input{1|2|3|4}"
	exit 0;
fi

# 传入内容,格式化内容输出,可以传入多个参数,用空格隔开
output_msg() {
	for msg in $*; do
		action $msg /bin/true
	done
}


# 判断命令是否存在,第一个参数 $1 为判断的命令,第二个参数为提供该命令的yum 软件包名称
check_yum_command() {
	output_msg "命令检查:$1"
	hash $1 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "`date +%F' '%H:%M:%S` check command $1 " >> ${install_log_path}${install_log_name} && return 0
	else
		yum -y install $2 > /dev/null 2>&1
	#    hash $Command || { echo "`date +%F' '%H:%M:%S` $2 is installed fail">>${install_log_path}${install_log_name} ; exit 1 }
	fi
}

# 判断目录是否存在,传入目录绝对路径,可以传入多个目录
check_dir() {
	output_msg "目录检查"
	for dirname in $*; do
		[ -d $dirname ] || mkdir -p $dirname > /dev/null 2>&1
		echo "`date +%F' '%H:%M:%S` $dirname check success!" >> ${install_log_path}${install_log_name}
	done
}

# 下载文件并解压至安装目录,传入url链接地址
download_file() {
	output_msg "下载源码包"
	mkdir -p $download_path
	for file in $*; do
		wget $file -c -P $download_path &> /dev/null
		if [ $? -eq 0 ]; then
			echo "`date +%F' '%H:%M:%S` $file download success!" >> ${install_log_path}${install_log_name}
		else
			echo "`date +%F' '%H:%M:%s` $file download fail!" >> ${install_log_path}${install_log_name} && exit 1
		fi
	done
}

# 安装grafana插件,传入安装的插件的名称
install_grafana_plugins() {
	output_msg "grafana插件安装"
	check_yum_command grafana-cli
	grafana-cli plugins install $* > /dev/null
	if [ $? -eq 0 ]; then
		echo "`date +%F' '%H:%M:%S` grafana plugins $* install success!" >> ${install_log_path}${install_log_name}
	else
		echo "`date +%F' '%H:%M:%s` grafana plugins $* install success!" >> ${install_log_path}${install_log_name} && exit 1
	fi


}

main() {
	check_dir $install_log_path $install_path
	check_yum_command wget wget
	download_file $URL
	for filename in `ls $download_path`; do
		yum -y install $download_path$filename > /dev/null 2>&1
	done
	install_grafana_plugins alexanderzobnin-zabbix-app
}

main

