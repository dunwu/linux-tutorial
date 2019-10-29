#!/usr/bin/env bash

##############################################################
# 很多场景下，我们需要在执行脚本时，输入指定的参数，脚本会
# 根据参数执行不同的行为。这就需要读取脚本参数并校验。
##############################################################

################### 读取脚本输入参数并校验 ###################
declare -a serial
serial=( start stop restart )
echo -n "请选择操作（可选值：start|stop|restart）："
read oper
if ! echo ${serial[@]} | grep -q ${oper}; then
	echo "请选择正确操作（可选值：start|stop|restart）"
	exit 1
fi

declare -a serial2
serial2=( dev test prod )
echo -n "请选择运行环境（可选值：dev|test|prod）："
read profile
if ! echo ${serial2[@]} | grep -q ${profile}; then
	echo "请选择正确运行环境（可选值：dev|test|prod）"
	exit 1
fi
