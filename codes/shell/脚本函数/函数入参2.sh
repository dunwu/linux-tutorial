#!/usr/bin/env bash

runner() {
	return 0
}

name=zp
paramsFunction() {
	echo "函数第一个入参：$1"
	echo "函数第二个入参：$2"
	echo "传递到脚本的参数个数：$#"
	echo "所有参数："
	printf "+ %s\n" "$*"
	echo "脚本运行的当前进程 ID 号：$$"
	echo "后台运行的最后一个进程的 ID 号：$!"
	echo "所有参数："
	printf "+ %s\n" "$@"
	echo "Shell 使用的当前选项：$-"
	runner
	echo "runner 函数的返回值：$?"
}

paramsFunction 1 "abc" "hello, \"zp\""
#  Output:
#  函数第一个入参：1
#  函数第二个入参：abc
#  传递到脚本的参数个数：3
#  所有参数：
#  + 1 abc hello, "zp"
#  脚本运行的当前进程 ID 号：26400
#  后台运行的最后一个进程的 ID 号：
#  所有参数：
#  + 1
#  + abc
#  + hello, "zp"
#  Shell 使用的当前选项：hB
#  runner 函数的返回值：0
