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

JAVA_OPTS=""
APP_OPTS=""
packageJavaOpts() {

	# GC OPTS
	JAVA_OPTS="${JAVA_OPTS} -server -Xms8g -Xmx16g -Xss512k"
	JAVA_OPTS="${JAVA_OPTS} -XX:+UseParallelOldGC -XX:+UseAdaptiveSizePolicy -XX:MaxGCPauseMillis=150"
	JAVA_OPTS="${JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom"

	# DEBUG OPTS
	if [[ ${debug} == "on" ]]; then

		# Remote Debug
		JAVA_OPTS="${JAVA_OPTS} -Xdebug -Xnoagent -Djava.compiler=NONE"
		JAVA_OPTS="${JAVA_OPTS} -Xrunjdwp:transport=dt_socket,address=28889,server=y,suspend=n"

		# GC LOG
		JAVA_OPTS="${JAVA_OPTS} -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps"
		JAVA_OPTS="${JAVA_OPTS} -verbose:gc -Xloggc:${LOG_PATH}/${APP_NAME}.gc.log"
		JAVA_OPTS="${JAVA_OPTS} -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=100M"

		# Heap Dump
		JAVA_OPTS="${JAVA_OPTS} -XX:-OmitStackTraceInFastThrow -XX:+HeapDumpOnOutOfMemoryError"
		JAVA_OPTS="${JAVA_OPTS} -XX:HeapDumpPath=${LOG_PATH}/${APP_NAME}.heapdump.hprof"

		# JMX OPTS
		IP=`ip addr | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | cut -d/ -f1`
		JAVA_OPTS="${JAVA_OPTS} -Dcom.sun.management.jmxremote=true"
		JAVA_OPTS="${JAVA_OPTS} -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
		JAVA_OPTS="${JAVA_OPTS} -Djava.rmi.server.hostname=${IP} -Dcom.sun.management.jmxremote.port=18889"
	fi

	# APP OPTS
	JAVA_OPTS="${JAVA_OPTS} -Dsun.net.inetaddr.ttl=60 -Djava.net.preferIPv4Stack=true"
	JAVA_OPTS="${JAVA_OPTS} -Dspring.profiles.active=${profile} -Dfile.encoding=UTF-8"

	# CLASSPATH
	APP_OPTS=" -classpath lib/* -Dlogging.config=file:./config/logback.dev.xml --spring.config.location=classpath:/,classpath:/config/,file:./,file:./config/"
}

# 检查服务是否已经启动
pid=""
checkStarted() {
	pid=`ps -ef | grep java | grep ${APP_NAME} | awk '{print $2}'`
	if [[ -n "${pid}" ]]; then
		return 0
	else
		return 1
	fi
}

main() {
	case "${oper}" in
		start)
			startServer
		;;
		stop)
			stopServer
		;;
		restart)
			stopServer
			sleep 5
			startServer
		;;
		*)
			echo "Invalid oper: ${oper}."
			exit 1
	esac

	exit 0
}

stopServer() {
	echo -n "stopping server: "
	if checkStarted; then
		kill -9 ${pid}
		printf "${GREEN}\n${APP_NAME} is stopped.${RESET}\n"
	else
		printf "${RED}\n${APP_NAME} fail to stop.${RESET}\n"
	fi
}

startServer() {
	printf "${BLUE}starting ${APP_NAME}...${RESET}\n"
	if checkStarted; then
		printf "${YELLOW}[WARN] ${APP_NAME} already started!${RESET}\n"
		printf "PID: ${pid}\n"
		exit 1
	fi

	packageJavaOpts
	printf "${CYAN}JVM OPTS:\n ${JAVA_OPTS}${RESET}\n"
	if [[ ! -f "${LOG_PATH}/start.out" ]]; then
		touch "${LOG_PATH}/start.out"
	fi
	nohup java ${JAVA_OPTS} -jar ${ROOT_DIR}/../spring-boot-app.jar ${APP_OPTS} >> ${LOG_PATH}/start.out 2>&1 &
	printf "${GREEN}\n${APP_NAME} is started.${RESET}\n"
}

######################################## MAIN ########################################
# 设置环境变量
export LANG="zh_CN.UTF-8"
ROOT_DIR=$(pwd)

APP_NAME=spring-boot-app
LOG_PATH=${ROOT_DIR}/../logs
mkdir -p ${LOG_PATH}

declare -a serial
serial=( start stop restart )
echo -n "请选择操作（可选值：start|stop|restart）："
read oper
if ! echo "${serial[@]}" | grep -q ${oper}; then
	echo "请选择正确操作（可选值：start|stop|restart）"
	exit 1
fi

if [[ ${oper} == "start" ]] || [[ "${oper}" == "restart" ]]; then
	declare -a serial2
	serial2=( prod dev test )
	echo -n "选择 profile（可选值：prod|dev|test）："
	read profile
	if ! echo "${serial2[@]}" | grep -q ${profile}; then
		echo "请选择正确 profile（可选值：prod|dev|test）"
		exit 1
	fi

	declare -a serial3
	serial3=( on off )
	echo -n "是否启动 debug 模式（可选值：on|off）："
	read debug
	if ! echo "${serial3[@]}" | grep -q ${debug}; then
		echo "是否启动 debug 模式（可选值：on|off）"
		exit 1
	fi
fi

main
