#!/usr/bin/env bash

x=10
if [[ -n $1 ]]; then
	x=$1
fi

y=20
if [[ -n $2 ]]; then
	y=$2
fi

echo "x=${x}, y=${y}"

if [[ ${x} != ${y} ]]; then
	echo "${x} != ${y} : x 不等于 y"
else
	echo "${x} != ${y}: x 等于 y"
fi

if [[ ${x} -lt 100 && ${y} -gt 15 ]]; then
	echo "${x} 小于 100 且 ${y} 大于 15 : 返回 true"
else
	echo "${x} 小于 100 且 ${y} 大于 15 : 返回 false"
fi

if [[ ${x} -lt 100 || ${y} -gt 100 ]]; then
	echo "${x} 小于 100 或 ${y} 大于 100 : 返回 true"
else
	echo "${x} 小于 100 或 ${y} 大于 100 : 返回 false"
fi

if [[ ${x} -lt 5 || ${y} -gt 100 ]]; then
	echo "${x} 小于 5 或 ${y} 大于 100 : 返回 true"
else
	echo "${x} 小于 5 或 ${y} 大于 100 : 返回 false"
fi

#  Output:
#  x=10, y=20
#  10 != 20 : x 不等于 y
#  10 小于 100 且 20 大于 15 : 返回 true
#  10 小于 100 或 20 大于 100 : 返回 true
#  10 小于 5 或 20 大于 100 : 返回 false
