#!/usr/bin/env bash

#################################################################################
# JAVA 应用运行脚本
# @author: Zhang Peng
#################################################################################

# 检查脚本参数，如必要参数未传入，退出脚本。
function checkInput() {
	if [ "${profile}" == "" ] || [ "${oper}" == "" ]; then
		echo "请输入脚本参数：profile oper [debug]"
		echo "    profile: 运行环境（必填）。可选值：development|test"
		echo "    oper: 运行环境（必填）。可选值：start|stop|restart"
		echo "    debug: debug启动开关。默认不填为不启动。"
		exit 0
	fi
}

#检查文件是否存在，不存在则退出脚本
function checkFileExist() {
	if [ ! -f "$1" ]
	then
		echo "关键文件 $1 找不到，脚本执行结束"
		exit 0
	fi
}

# 封装启动参数，调用启动脚本
function main() {
	APP_NAME=ck-lion

	# JVM 参数
	JAVA_OPTS=" -Djava.awt.headless=true -Dfile.encoding=UTF8 -Djava.net.preferIPv4Stack=true -Ddubbo.shutdown.hook=true -Dspring.profiles.active=${profile} -Djava.security.egd=file:/dev/./urandom -Xms1024m -Xmx1024m -Xss2m "
	JAVA_DEBUG_OPTS=""
	if [ "$2" == "debug" ]; then
		JAVA_DEBUG_OPTS=" -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=2236,server=y,suspend=n "
		shift
	fi
	javaArgs=" ${JAVA_OPTS} ${JAVA_DEBUG_OPTS} "

	# classpath 参数
	classpathArgs="${SERVER_ROOT}/WEB-INF/classes:${SERVER_ROOT}/WEB-INF/lib/*"

	# 启动类
	bootstrapClass="com.alibaba.dubbo.container.Main"

	${SCRIPT_DIR}/java-app-boot.sh ${APP_NAME} ${oper} "${javaArgs}" "${classpathArgs}" "${bootstrapClass}"
	execode=$?
	if [ "${execode}" == "0" ]; then
		echo "执行操作成功"
	else
		echo "执行操作失败"
		exit 1
	fi
}

######################################## MAIN ########################################
# 设置环境变量
export LANG="zh_CN.UTF-8"

# 设置全局常量
SCRIPT_DIR=$(cd "$(dirname "$0")";
pwd)
SOURCE_DIR=/home/zp/source/
APP_NAME=XXX
SERVER_ROOT=/home/zp/source/${APP_NAME}/target/

# 0. 获取传入参数并检查
profile=$1
oper=$2
debug=$3
checkInput

# 1. 执行操作
main
