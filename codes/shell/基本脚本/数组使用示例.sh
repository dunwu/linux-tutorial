#!/usr/bin/env bash

################### 创建数组 ###################
nums=( [ 2 ] = 2 [ 0 ] = 0 [ 1 ] = 1 )
colors=( red yellow "dark blue" )

################### 访问数组的单个元素 ###################
echo ${nums[1]}
# Output: 1

################### 访问数组的所有元素 ###################
echo ${colors[*]}
# Output: red yellow dark blue

echo ${colors[@]}
# Output: red yellow dark blue

printf "+ %s\n" ${colors[*]}
# Output:
# + red
# + yellow
# + dark
# + blue

printf "+ %s\n" "${colors[*]}"
# Output:
# + red yellow dark blue

printf "+ %s\n" "${colors[@]}"
# Output:
# + red
# + yellow
# + dark blue

################### 访问数组的部分元素 ###################
echo ${nums[@]:0:2}
# Output:
# 0 1

################### 获取数组长度 ###################
echo ${#nums[*]}
# Output:
# 3

################### 向数组中添加元素 ###################
colors=( white "${colors[@]}" green black )
echo ${colors[@]}
# Output:
# white red yellow dark blue green black

################### 从数组中删除元素 ###################
unset nums[ 0 ]
echo ${nums[@]}
# Output:
# 1 2
