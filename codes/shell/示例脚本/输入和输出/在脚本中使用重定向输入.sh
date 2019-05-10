#!/bin/bash
# redirecting the inpiut

# 从test中读取数据，而不是从STDIN中读取数据
exec 0< test
count=1
while read line
do
	echo "Line #$count : $line "
	count=$[ $count +1 ]
done

