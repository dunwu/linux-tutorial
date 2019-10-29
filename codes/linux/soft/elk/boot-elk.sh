#!/usr/bin/env bash

# 检查脚本输入参数
checkInput() {
	if [ "${app}" == "" ] || [ "${oper}" == "" ]; then
		echo "请输入脚本参数：name"
		echo "    app: 要启动的进程关键字（必填）。可选值：elasticsearch|logstash|kibana|filebeat"
		echo "    oper: 执行操作（必填）。可选值：start|stop"
		echo "例：./boot-elk.sh logstash start"
		exit 0
	fi

	if [ "${app}" != "elasticsearch" ] && [ "${app}" != "logstash" ] && [ "${app}" != "kibana" ] && [ "${app}" != "filebeat" ]; then
		echo "name 输入错误"
		echo "可选值：elasticsearch|logstash|kibana|filebeat"
		exit 0
	fi
}

# 检查文件是否存在，不存在则退出脚本
checkFileExist() {
	if [ ! -f "$1" ]
	then
		echo "关键文件 $1 找不到，脚本执行结束"
		exit 0
	fi
}

startup() {
	if [ "${app}" == "elasticsearch" ]; then
		checkFileExist ${ELASTICSEARCH_BIN_PATH}/elasticsearch
		nohup sh ${ELASTICSEARCH_BIN_PATH}/elasticsearch >> ${ELASTICSEARCH_BIN_PATH}/nohup.out 2>&1 &
	elif [ "${app}" == "logstash" ]; then
		checkFileExist ${LOGSTASH_BIN_PATH}/logstash
		nohup sh ${LOGSTASH_BIN_PATH}/logstash -f ${LOGSTASH_BIN_PATH}/logstash.conf >> ${LOGSTASH_BIN_PATH}/nohup.out 2>&1 &
	elif [ "${app}" == "kibana" ]; then
		checkFileExist ${KIBANA_BIN_PATH}/kibana
		nohup sh ${KIBANA_BIN_PATH}/kibana >> ${KIBANA_BIN_PATH}/nohup.out 2>&1 &
	elif [ "${app}" == "filebeat" ]; then
		checkFileExist ${FILEBEAT_PATH}/filebeat
		touch ${FILEBEAT_PATH}/nohup.out
		nohup ${FILEBEAT_PATH}/filebeat -e -c ${FILEBEAT_PATH}/filebeat.yml -d "publish" >> ${FILEBEAT_PATH}/nohup.out 2>&1 &
	fi
}

shutdown() {
	pid=`ps -ef | grep java | grep ${app} | awk '{print $2}'`
	kill -9 ${pid}
}

##############################__MAIN__########################################
app=$1
oper=$2

version=6.1.1
ELASTICSEARCH_BIN_PATH=/opt/elastic/elasticsearch-${version}/bin
LOGSTASH_BIN_PATH=/opt/elastic/logstash-${version}/bin
KIBANA_BIN_PATH=/opt/elastic/kibana-${version}-linux-x86_64/bin
FILEBEAT_PATH=/opt/elastic/filebeat-${version}-linux-x86_64

checkInput
case ${oper} in
	start)
		echo "启动 ${app}"
		startup
	;;
	stop)
		echo "终止 ${app}"
		shutdown
	;;
	*) echo "${oper} is invalid oper" ;;
esac

