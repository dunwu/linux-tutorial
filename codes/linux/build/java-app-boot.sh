#!/usr/bin/env bash

#################################################################################
# JAVA 应用通用启动脚本
# @author: Zhang Peng
#################################################################################

# 检查脚本参数，如必要参数未传入，退出脚本。
function checkInput() {
	if [ "${app}" == "" ] || [ "${oper}" == "" ] || [ "${javaArgs}" == "" ] || [ "${classpathArgs}" == "" ] || [ "${bootstrapClass}" == "" ]; then
		echo "请输入脚本参数：app oper javaArgs classpathArgs bootstrapClass"
		echo "    app: 应用名。"
		echo "    oper: 运行环境（必填）。可选值：start|stop|restart"
		echo "    javaArgs: JVM 参数（必填）。"
		echo "    classpathArgs: classpath参数（必填）。"
		echo "    bootstrapClass: 启动类（必填）。"
		exit 0
	fi
}

# 检查文件夹是否存在，不存在则创建
function createFolderIfNotExist() {
	if [ ! -d "$1" ]; then
		mkdir -p "$1"
	fi
}

# 检查服务是否已经启动
pids=""
function checkStarted() {
	pids=`ps -ef | grep java | grep ${app} | awk '{print $2}'`
	if [ -n "${pids}" ]; then
		return 0
	else
		return 1
	fi
}

function main() {
	case "${oper}" in
		start)
			echo -n "starting server: "
			# 检查服务是否已经启动
			if checkStarted; then
				echo "ERROR: server already started!"
				echo "PID: ${pids}"
				exit 1
			fi

			args="${javaArgs} -classpath ${classpathArgs} ${bootstrapClass}"
			echo -e "statup params:\n ${args}"

			#启动服务
			touch ${LOG_DIR}/${app}-startup.log
			nohup java ${args} > ${LOG_DIR}/${app}-startup.log 2>&1 &
			# echo -e "执行参数：\n${args}"
			echo -e "\nthe server is started..."
		;;
		stop)
			echo -n "stopping server: "
			#dubbo提供优雅停机, 不能使用kill -9
			if checkStarted; then
				kill ${pids}
				echo -e "\nthe server is stopped..."
			else
				echo -e "\nno server to be stopped..."
			fi
		;;
		restart)
			$0 ${app} stop "${javaArgs}" "${classpathArgs}" "${bootstrapClass}"
			sleep 5
			$0 ${app} start "${javaArgs}" "${classpathArgs}" "${bootstrapClass}"
		;;
		*)
			echo "Invalid oper: ${oper}."
			exit 1
	esac

	exit 0
}

######################################## MAIN ########################################
# 设置环境变量
export LANG="zh_CN.UTF-8"

# 获取输入参数
app=`echo $1`
oper=`echo $2`
javaArgs=`echo $3`
classpathArgs=`echo $4`
bootstrapClass=`echo $5`
vars=$*
checkInput

# 设置全局常量
LOG_DIR=/home/zp/log
createFolderIfNotExist ${LOG_DIR}

# 执行 main 方法
main
