#!/usr/bin/env bash

#bash shell 仅能处理浮点数值,test命令无法处理val1变量中存储的浮点值

#testing floating point numbers

val1=`echo "scale=4; 10 / 3" | bc`
echo "The test value is $val1"
if [ $val1 -gt 3 ]
then
	echo "The result is larger than 3"
fi
