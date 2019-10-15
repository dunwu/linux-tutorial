#!/usr/bin/env bash

# 打印10以内的奇数
for (( i = 0; i < 10; i ++ )); do
	if [[ $((i % 2)) -eq 0 ]]; then
		continue
	fi
	echo ${i}
done
#  Output:
#  1
#  3
#  5
#  7
#  9

# 多重循环中的 continue 用法
for (( a = 1; a <= 5; a ++ ))
do
	echo "Iteration $a:"
	for (( b = 1; b < 3; b ++ ))
	do
		if [[ $a -gt 2 ]] && [[ $a -lt 4 ]]
		then
			continue 2
		fi
		var3=$[ $a * $b ]
		echo " The result of $a * $b is $var3"
	done
done
