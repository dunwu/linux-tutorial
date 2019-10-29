#!/usr/bin/env bash

################### if 语句 ###################
# 写成一行
if [[ 1 -eq 1 ]]; then
	echo "1 -eq 1 result is: true";
fi
# Output: 1 -eq 1 result is: true

# 写成多行
if [[ "abc" -eq "abc" ]]
then
	echo ""abc" -eq "abc" result is: true"
fi
# Output: abc -eq abc result is: true

################### if else 语句 ###################
if [[ 2 -ne 1 ]]; then
	echo "true"
else
	echo "false"
fi
# Output: true

################### if elif else 语句 ###################
x=10
y=20
if [[ ${x} > ${y} ]]; then
	echo "${x} > ${y}"
elif [[ ${x} < ${y} ]]; then
	echo "${x} < ${y}"
else
	echo "${x} = ${y}"
fi
# Output: 10 < 20
