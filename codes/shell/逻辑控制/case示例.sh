#!/usr/bin/env bash

echo "input param: " $1 $2 $3

x=0
if [[ -n $1 ]]; then
	x=$1
fi

oper=""
if [[ -n $2 ]]; then
	oper=$2
fi

y=0
if [[ -n $3 ]]; then
	y=$3
fi

exec
case ${oper} in
	+ | add)
		val=`expr ${x} + ${y}`
		echo "${x} + ${y} = ${val}"
	;;
	- | sub)
		val=`expr ${x} - ${y}`
		echo "${x} - ${y} = ${val}"
	;;
	* | mul)
		val=`expr ${x} \* ${y}`
		echo "${x} * ${y} = ${val}"
	;;
	/ | div)
		val=`expr ${x} / ${y}`
		echo "${x} / ${y} = ${val}"
	;;
	*)
		echo "Unknown oper!"
	;;
esac
