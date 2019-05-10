#!/bin/bash
# 大于小于号必须转义，否则shell会将它们当做重定向符号而把字符串值当做文件名处理
# 大于小于号顺序和sort命令所采用的有所不同
# mis-using string comparisons

val1=baseball
val2=hockey

if [ $val1 > $val2 ]
then
	echo "$val1 is greater than $val2"
else
	echo "$val1 is less than $val2"
fi
