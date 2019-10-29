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

if [[ ${x} -lt 100 && ${y} -gt 100 ]]
then
	echo "${x} -lt 100 && ${y} -gt 100 返回 true"
else
	echo "${x} -lt 100 && ${y} -gt 100 返回 false"
fi

if [[ ${x} -lt 100 || ${y} -gt 100 ]]
then
	echo "${x} -lt 100 || ${y} -gt 100 返回 true"
else
	echo "${x} -lt 100 || ${y} -gt 100 返回 false"
fi

#  Output:
#  x=10, y=20
#  10 -lt 100 && 20 -gt 100 返回 false
#  10 -lt 100 || 20 -gt 100 返回 true
