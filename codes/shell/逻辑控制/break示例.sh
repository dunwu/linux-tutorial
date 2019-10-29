#!/usr/bin/env bash

################### 使用break跳出外部循环 ###################
# 查找 10 以内第一个能整除 2 和 3 的正整数
i=1
while [[ ${i} -lt 10 ]]; do
	if [[ $((i % 3)) -eq 0 ]] && [[ $((i % 2)) -eq 0 ]]; then
		echo ${i}
		break;
	fi
	i=`expr ${i} + 1`
done
# Output: 6
