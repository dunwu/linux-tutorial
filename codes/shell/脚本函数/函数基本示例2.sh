#!/usr/bin/env bash

calc() {
	PS3="choose the oper: "
	select oper in "+" "-" "*" "/" # 生成操作符选择菜单
	do
	echo -n "enter first num: " && read x # 读取输入参数
	echo -n "enter second num: " && read y # 读取输入参数
	exec
	case ${oper} in
		"+")
			return $((${x} + ${y}))
		;;
		"-")
			return $((${x} - ${y}))
		;;
		"*")
			return $((${x} * ${y}))
		;;
		"/")
			return $((${x} / ${y}))
		;;
		*)
			echo "${oper} is not support!"
			return 0
		;;
	esac
	break
	done
}

calc
echo "the result is: $?" # $? 获取 calc 函数返回值
#  $ ./function-demo.sh
#  1) +
#  2) -
#  3) *
#  4) /
#  choose the oper: 3
#  enter first num: 10
#  enter second num: 10
#  the result is: 100
