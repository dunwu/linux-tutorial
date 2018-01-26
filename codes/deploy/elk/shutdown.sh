#!/bin/bash -li

app=$1

checkInput() {
  if [ "${app}" == "" ]; then
    echo "请输入脚本参数：name"
    echo "    name: 要终止的进程关键字（必填）。可选值：elasticsearch|logstash|kibana|filebeat"
    echo "例：./shutdown.sh logstash"
    exit 0
  fi
  if [ "${app}" != "elasticsearch" ] && [ "${app}" != "logstash" ] && [ "${app}" != "kibana" ] && [ "${app}" != "filebeat" ]; then
    echo "name 输入错误"
    echo "可选值：elasticsearch|logstash|kibana|filebeat"
    exit 0
  fi
}

shutdown() {
  PID=`ps -ef | grep ${app} | awk '{ print $2}' | head -n 1`
  kill -9 ${PID}
}

##############################__MAIN__########################################
checkInput
shutdown

