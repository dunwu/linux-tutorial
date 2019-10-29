
#!/usr/bin/env bash

x="abc"
if [[ -n $1 ]]; then
	x=$1
fi

y="xyz"
if [[ -n $2 ]]; then
	y=$2
fi

echo "x=${x}, y=${y}"

if [[ ${x} = ${y} ]]; then
	echo "${x} = ${y} : x 等于 y"
else
	echo "${x} = ${y}: x 不等于 y"
fi

if [[ ${x} != ${y} ]]; then
	echo "${x} != ${y} : x 不等于 y"
else
	echo "${x} != ${y}: x 等于 y"
fi

if [[ -z ${x} ]]; then
	echo "-z ${x} : 字符串长度为 0"
else
	echo "-z ${x} : 字符串长度不为 0"
fi

if [[ -n "${x}" ]]; then
	echo "-n ${x} : 字符串长度不为 0"
else
	echo "-n ${x} : 字符串长度为 0"
fi

if [[ ${x} ]]; then
	echo "${x} : 字符串不为空"
else
	echo "${x} : 字符串为空"
fi

#  Output:
#  x=abc, y=xyz
#  abc = xyz: x 不等于 y
#  abc != xyz : x 不等于 y
#  -z abc : 字符串长度不为 0
#  -n abc : 字符串长度不为 0
#  abc : 字符串不为空
