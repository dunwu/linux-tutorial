#!/usr/bin/env bash

# 打印UI页头信息
function printHeadInfo() {
	cat << EOF
***********************************************************************************
* 欢迎使用项目引导式发布脚本。
* 输入任意键进入脚本操作。
***********************************************************************************
EOF
}

# 打印UI页尾信息
function printFootInfo() {
	cat << EOF


***********************************************************************************
* 安装过程结束。
* 输入任意键进入脚本操作。
* 如果不想安装其他应用，输入 exit 回车或输入 <CTRL-C> 退出。
***********************************************************************************
EOF
}

# 检查文件是否存在，不存在则退出脚本
function checkFileExist() {
	if [ ! -f "$1" ]
	then
		echo "关键文件 $1 找不到，脚本执行结束"
		exit 1
	fi
}

# 检查文件夹是否存在，不存在则创建
function createFolderIfNotExist() {
	if [ ! -d "$1" ]; then
		mkdir -p "$1"
	fi
}

# 记录发布的版本信息
# 第一个参数为日志所在路径
# 第二个参数为应用名称
# 第三个参数为代码分支
# 第四个参数为运行环境
function saveVersionInfo() {
	if [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ] || [ "$4" == "" ]; then
		echo "缺少参数，退出"
		exit 1
	fi

	VERSION_LOG_FILE=$1/$2-version.log
	rm -rf ${VERSION_LOG_FILE}
	touch ${VERSION_LOG_FILE}
	chmod 777 ${VERSION_LOG_FILE}

	echo -e "\n=================== $2 ===================" >> ${VERSION_LOG_FILE}
	echo "Branch is: $3" >> ${VERSION_LOG_FILE}
	echo "Profile is: $4" >> ${VERSION_LOG_FILE}
	echo "CommitID is : $(git log --pretty=oneline -1)" >> ${VERSION_LOG_FILE}
}
