#!/usr/bin/env bash

################### 声明变量 ###################
name="world"
echo "hello ${name}"
# Output: hello world

################### 输出变量 ###################
folder=$(pwd)
echo "current path: ${folder}"

################### 只读变量 ###################
rword="hello"
echo ${rword}
# Output: hello
readonly rword
# rword="bye"  # 如果放开注释，执行时会报错

################### 删除变量 ###################
dword="hello" # 声明变量
echo ${dword} # 输出变量值
# Output: hello

unset dword # 删除变量
echo ${dword}
# Output: （空）

################### 系统变量 ###################
echo "UID:$UID"
echo LOGNAME:$LOGNAME
echo User:$USER
echo HOME:$HOME
echo PATH:$PATH
echo HOSTNAME:$HOSTNAME
echo SHELL:$SHELL
echo LANG:$LANG

################### 自定义变量 ###################
days=10
user="admin"
echo "$user logged in $days days age"
days=5
user="root"
echo "$user logged in $days days age"
# Output:
# admin logged in 10 days age
# root logged in 5 days age

################### 从变量读取列表 ###################
colors="Red Yellow Blue"
colors=$colors" White Black"

for color in $colors
do
	echo " $color"
done
