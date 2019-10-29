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

val=`expr ${x} + ${y}`
echo "${x} + ${y} = $val"

val=`expr ${x} - ${y}`
echo "${x} - ${y} = $val"

val=`expr ${x} \* ${y}`
echo "${x} * ${y} = $val"

val=`expr ${y} / ${x}`
echo "${y} / ${x} = $val"

val=`expr ${y} % ${x}`
echo "${y} % ${x} = $val"

if [[ ${x} == ${y} ]]; then
	echo "${x} = ${y}"
fi
if [[ ${x} != ${y} ]]; then
	echo "${x} != ${y}"
fi

#  Execute: ./算术运算符.sh
#  Output:
#  x=10, y=20
#  10 + 20 = 30
#  10 - 20 = -10
#  10 * 20 = 200
#  20 / 10 = 2
#  20 % 10 = 0
#  10 != 20

#  Execute: ./算术运算符.sh 10 30
#  Output:
#  x=10, y=30
#  10 + 30 = 40
#  10 - 30 = -20
#  10 * 30 = 300
#  30 / 10 = 3
#  30 % 10 = 0
#  10 不等于 30
