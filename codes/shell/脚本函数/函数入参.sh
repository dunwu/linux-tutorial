#!/usr/bin/env bash

x=0
if [[ -n $1 ]]; then
	echo "第一个参数为：$1"
	x=$1
else
	echo "第一个参数为空"
fi

y=0
if [[ -n $2 ]]; then
	echo "第二个参数为：$2"
	y=$2
else
	echo "第二个参数为空"
fi

paramsFunction() {
	echo "函数第一个入参：$1"
	echo "函数第二个入参：$2"
}

paramsFunction ${x} ${y}
