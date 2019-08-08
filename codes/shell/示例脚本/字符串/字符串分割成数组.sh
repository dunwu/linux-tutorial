#!/usr/bin/env bash

# ----------------------------------------------------------------------------------
# 根据特定字符将一个字符串分割成数组
# ----------------------------------------------------------------------------------

str="0.0.0.1"
OLD_IFS="$IFS"
IFS="."
array=(${str})
IFS="$OLD_IFS"
size=${#array[*]}
lastIndex=`expr ${size} - 1`
echo "数组长度：${size}"
echo "最后一个数组元素：${array[${lastIndex}]}"
for item in ${array[@]}
do
  echo "$item"
done
