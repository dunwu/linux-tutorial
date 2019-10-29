#!/usr/bin/env bash

################### for 语句 ###################
echo "print 0 to 9"
for (( j = 0; j < 10; j ++ )); do
	echo ${j}
done
#  Output:
#  print 0 to 9
#  0
#  1
#  2
#  3
#  4
#  5
#  6
#  7
#  8
#  9

################### for in 语句 ###################
echo "print 1 to 5"
for i in {1..5}; do
	echo ${i};
done
#  Output:
#  print 1 to 5
#  1
#  2
#  3
#  4
#  5

################### for in 语句遍历文件 ###################
DIR=/home/zp
for FILE in ${DIR}/*.sh; do
	mv "$FILE" "${DIR}/scripts"
done
# 将 /home/zp 目录下所有 sh 文件拷贝到 /home/zp/scripts

################### 在 for 语句中使用多个变量 ###################
for (( x = 1 , y = 10; x <= y; x ++ , y -- ))
do
	echo "$y - $x = $(($y - $x))"
done

################### 嵌套 for 循环 ###################
for (( x = 1; x <= 3; x ++ ))
do
	echo "Starting loop $x:"
	for (( y = 1; y <= 3; y ++ ))
	do
		echo "Inside loog: $y:"
	done
done
#Output
#Starting loop 1:
#Inside loog: 1:
#Inside loog: 2:
#Inside loog: 3:
#Starting loop 2:
#Inside loog: 1:
#Inside loog: 2:
#Inside loog: 3:
#Starting loop 3:
#Inside loog: 1:
#Inside loog: 2:
#Inside loog: 3:
