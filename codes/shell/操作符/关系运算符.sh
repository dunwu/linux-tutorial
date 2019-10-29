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

if [[ ${x} -eq ${y} ]]; then
	echo "${x} -eq ${y} : x 等于 y"
else
	echo "${x} -eq ${y}: x 不等于 y"
fi

if [[ ${x} -ne ${y} ]]; then
	echo "${x} -ne ${y}: x 不等于 y"
else
	echo "${x} -ne ${y}: x 等于 y"
fi

if [[ ${x} -gt ${y} ]]; then
	echo "${x} -gt ${y}: x 大于 y"
else
	echo "${x} -gt ${y}: x 不大于 y"
fi

if [[ ${x} -lt ${y} ]]; then
	echo "${x} -lt ${y}: x 小于 y"
else
	echo "${x} -lt ${y}: x 不小于 y"
fi

if [[ ${x} -ge ${y} ]]; then
	echo "${x} -ge ${y}: x 大于或等于 y"
else
	echo "${x} -ge ${y}: x 小于 y"
fi

if [[ ${x} -le ${y} ]]; then
	echo "${x} -le ${y}: x 小于或等于 y"
else
	echo "${x} -le ${y}: x 大于 y"
fi

#  Output:
#  x=10, y=20
#  10 -eq 20: x 不等于 y
#  10 -ne 20: x 不等于 y
#  10 -gt 20: x 不大于 y
#  10 -lt 20: x 小于 y
#  10 -ge 20: x 小于 y
#  10 -le 20: x 小于或等于 y
