#!/bin/bash
# auth:kaliarch
# version:v1.0
# func:zookeeper 3.4/3.5 安装

# 定义安装目录、及日志信息
. /etc/init.d/functions
[ $(id -u) != "0" ] && echo "Error: You must be root to run this script" && exit 1
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
download_path=/tmp/tmpdir/
install_log_name=install_zookeeper.log
env_file=/etc/profile.d/zookeeper.sh
install_log_path=/var/log/appinstall/
install_path=/usr/local/
software_config_file=${install_path}zookeeper/conf/zoo.cfg

clear
echo "##########################################"
echo "#                                        #"
echo "#      安装 zookeeper 3.4/3.5            #"
echo "#                                        #"
echo "##########################################"
echo "1: Install zookeeper 3.4"
echo "2: Install zookeeper 3.5"
echo "3: EXIT"
# 选择安装软件版本
read -p "Please input your choice:" softversion
if [ "${softversion}" == "1" ];then
        URL="https://anchnet-script.oss-cn-shanghai.aliyuncs.com/zookeeper/zookeeper-3.4.12.tar.gz"
elif [ "${softversion}" == "2" ];then
        URL="https://anchnet-script.oss-cn-shanghai.aliyuncs.com/zookeeper/zookeeper-3.5.4-beta.tar.gz"
elif [ "${softversion}" == "3" ];then
        echo "you choce channel!"
        exit 1;
else
        echo "input Error! Place input{1|2|3}"
        exit 0;
fi

# 传入内容,格式化内容输出,可以传入多个参数,用空格隔开
output_msg() {
    for msg in $*;do
        action $msg /bin/true
    done
}


# 判断命令是否存在,第一个参数 $1 为判断的命令,第二个参数为提供该命令的yum 软件包名称
check_yum_command() {
        output_msg "命令检查:$1"
        hash $1 >/dev/null 2>&1
        if [ $? -eq 0 ];then
            echo "`date +%F' '%H:%M:%S` check command $1 ">>${install_log_path}${install_log_name} && return 0
        else
            yum -y install $2 >/dev/null 2>&1
        #    hash $Command || { echo "`date +%F' '%H:%M:%S` $2 is installed fail">>${install_log_path}${install_log_name} ; exit 1 }
        fi
}

# 判断目录是否存在,传入目录绝对路径,可以传入多个目录
check_dir() {
    output_msg "目录检查"
    for dirname in $*;do
        [ -d $dirname ] || mkdir -p $dirname >/dev/null 2>&1
        echo "`date +%F' '%H:%M:%S` $dirname check success!" >> ${install_log_path}${install_log_name}
    done
}

# 下载文件并解压至安装目录,传入url链接地址
download_file() {
    output_msg "下载源码包"
    mkdir -p $download_path 
    for file in $*;do
        wget $file -c -P $download_path &> /dev/null
        if [ $? -eq 0 ];then
           echo "`date +%F' '%H:%M:%S` $file download success!">>${install_log_path}${install_log_name}
        else
           echo "`date +%F' '%H:%M:%s` $file download fail!">>${install_log_path}${install_log_name} && exit 1
        fi
    done
}


# 解压文件,可以传入多个压缩文件绝对路径,用空格隔开,解压至安装目录
extract_file() {
   output_msg "解压源码"
   for file in $*;do
       if [ "${file##*.}" == "gz" ];then
           tar -zxf $file -C $install_path && echo "`date +%F' '%H:%M:%S` $file extrac success!,path is $install_path">>${install_log_path}${install_log_name}
       elif [ "${file##*.}" == "zip" ];then
           unzip -q $file -d $install_path && echo "`date +%F' '%H:%M:%S` $file extrac success!,path is $install_path">>${install_log_path}${install_log_name}
       else
           echo "`date +%F' '%H:%M:%S` $file type error, extrac fail!">>${install_log_path}${install_log_name} && exit 1
       fi
    done
}

# 配置环境变量,第一个参数为添加环境变量的绝对路径
config_env() {
    output_msg "环境变量配置"
    echo "export PATH=\$PATH:$1" >${env_file}
    source ${env_file} && echo "`date +%F' '%H:%M:%S` 软件安装完成!">> ${install_log_path}${install_log_name}

}

# 添加配置文件
add_config() {
cat> $1 <<EOF
tickTime=2000                            #服务之间或者客户端与服务段之间心跳时间
initLimit=10                             #Follower启动过程中，从Leader同步所有最新数据的时间
syncLimit=5                              #Leader与集群之间的通信时间
dataDir=/usr/local/zookeeper/data        #zookeeper存储数据
datalogDir=/usr/local/zookeeper/logs     #zookeeper存储数据的日志
clientPort=2181                          #zookeeper默认端口
#server.1=127.0.0.1:2888:3888            #集群配置
EOF
}

main() {
check_dir $install_log_path $install_path
check_yum_command wget wget
download_file $URL

software_name=$(echo $URL|awk -F'/' '{print $NF}'|awk -F'.tar.gz' '{print $1}')
for filename in `ls $download_path`;do
    extract_file ${download_path}$filename
done
rm -fr ${download_path}
ln -s $install_path$software_name ${install_path}zookeeper
add_config ${software_config_file}
check_dir "${install_path}zookeeper/data" "${install_path}zookeeper/logs"
echo "1">${install_path}zookeeper/data/myid
config_env ${install_path}zookeeper/bin
}

main

