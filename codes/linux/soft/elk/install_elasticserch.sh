#!/usr/bin/env bash

# auth:kaliarch
# version:v1.0
# func:elasticsearch 5.4.1/6.0.1/6.3.1安装
# 定义安装目录、及日志信息
. /etc/init.d/functions
[ $(id -u) != "0" ] && echo "Error: You must be root to run this script" && exit 1
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
download_path=/tmp/tmpdir/
install_log_name=install_elasticsearch.log
env_file=/etc/profile.d/elasticsearch.sh
install_log_path=/var/log/appinstall/
install_path=/usr/local/
software_config_file=${install_path}elasticsearch/config/elasticsearch.yml
sysversion=$(rpm -q centos-release | cut -d- -f3)
jvm_conf="/usr/local/elasticsearch/config/jvm.options"
sys_mem=`free -m | grep Mem: | awk '{print $2}' | awk '{sum+=$1} END {print sum/1024}' | cut -d. -f1`
hostname=elk-server

clear
echo "##########################################"
echo "#                                        #"
echo "# 安装 elasticsearch 5.4.1/6.0.1/6.3.1   #"
echo "#                                        #"
echo "##########################################"
echo "1: Install elasticsearch 5.4.1"
echo "2: Install elasticsearch 6.0.1"
echo "3: Install elasticsearch 6.3.1"
echo "4: EXIT"
# 选择安装软件版本
read -p "Please input your choice:" softversion
if [ "${softversion}" == "1" ]; then
	URL="https://anchnet-script.oss-cn-shanghai.aliyuncs.com/elasticsearch/elasticsearch-5.4.1.tar.gz"
elif [ "${softversion}" == "2" ]; then
	URL="https://anchnet-script.oss-cn-shanghai.aliyuncs.com/elasticsearch/elasticsearch-6.0.1.tar.gz"
elif [ "${softversion}" == "3" ]; then
	URL="https://anchnet-script.oss-cn-shanghai.aliyuncs.com/elasticsearch/elasticsearch-6.3.1.tar.gz"
elif [ "${softversion}" == "4" ]; then
	echo "you choce channel!"
	exit 1;
else
	echo "input Error! Place input{1|2|3|4|5}"
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


# 解压文件,可以传入多个压缩文件绝对路径,用空格隔开,解压至安装目录
extract_file() {
	output_msg "解压源码"
	for file in $*; do
		if [ "${file##*.}" == "gz" ]; then
			tar -zxf $file -C $install_path && echo "`date +%F' '%H:%M:%S` $file extrac success!,path is $install_path" >> ${install_log_path}${install_log_name}
		elif [ "${file##*.}" == "zip" ]; then
			unzip -q $file -d $install_path && echo "`date +%F' '%H:%M:%S` $file extrac success!,path is $install_path" >> ${install_log_path}${install_log_name}
		else
			echo "`date +%F' '%H:%M:%S` $file type error, extrac fail!" >> ${install_log_path}${install_log_name} && exit 1
		fi
	done
}

# 配置环境变量,第一个参数为添加环境变量的绝对路径
config_env() {
	output_msg "环境变量配置"

	echo "export PATH=\$PATH:$1" > ${env_file}
	source ${env_file} && echo "`date +%F' '%H:%M:%S` 软件安装完成!" >> ${install_log_path}${install_log_name}

}

# 配置主机名，第一个为主机名
config_hostname() {
	if [ ${sysversion} -eq 6 ]; then
		hostname $1
	elif [ ${sysversion} -eq 7 ]; then
		hostnamectl set-hostname $1
	else
		echo "`date +%F' '%H:%M:%S` hostname $1 config fail" >> ${install_log_path}${install_log_name}
	fi
}

config_limits() {
	output_msg "配置limits"
	cat >> /etc/security/limits.conf << EOF
* soft nofile 65536
* hard nofile 65536
* soft nproc 65536
* hard nproc 65536
EOF
	echo "vm.max_map_count = 655360" >> /etc/sysctl.conf
	sysctl -p > /dev/null 2>&1

}

# 添加配置文件
add_config() {
	cat > $1 << EOF
cluster.name: my-application
node.name: ${hostname}
path.data: /usr/local/elasticsearch/data
path.logs: /usr/local/elasticsearch/logs
network.host: 127.0.0.1
http.port: 9200
discovery.zen.ping.unicast.hosts: ["$hostname"]
EOF
}

config_user() {
	useradd $1 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "`date +%F' '%H:%M:%S` $1 user add success" >> ${install_log_path}${install_log_name}
	else
		echo "`date +%F' '%H:%M:%S` $1 user add fail" >> ${install_log_path}${install_log_name} && exit 1
	fi
	chown ${1}.${1} ${install_path}elasticsearch/ -R
}

config_jvm() {
	if [ ${sys_mem} -eq 0 ]; then
		sed -i "s#`grep "^-Xmx" ${jvm_conf}`#"-Xmx512m"#g" ${jvm_conf}
		sed -i "s#`grep "^-Xms" ${jvm_conf}`#"-Xms512m"#g" ${jvm_conf}
	else
		sed -i "s#`grep "^-Xmx" ${jvm_conf}`#"-Xmx${sys_mem}g"#g" ${jvm_conf}
		sed -i "s#`grep "^-Xms" ${jvm_conf}`#"-Xms${sys_mem}g"#g" ${jvm_conf}
	fi
}


main() {
	check_dir $install_log_path $install_path
	check_yum_command wget wget
	download_file $URL
	config_hostname $hostname

	software_name=$(echo $URL | awk -F'/' '{print $NF}' | awk -F'.tar.gz' '{print $1}')
	for filename in `ls $download_path`; do
		extract_file ${download_path}$filename
	done

	rm -fr ${download_path}
	ln -s $install_path$software_name ${install_path}elasticsearch
	add_config $software_config_file
	check_dir ${install_path}elasticsearch/{data,logs}
	config_user elasticsearch
	config_env ${install_path}elasticsearch/bin
	config_limits
	config_jvm
	echo "请使用一下命令启动服务:'su - elasticsearch -c 'nohup /usr/local/elasticsearch/bin/elasticsearch &'"

}

main
