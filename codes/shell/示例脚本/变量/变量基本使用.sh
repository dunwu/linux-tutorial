#!/usr/bin/env bash

################### 声明变量 ###################
name="world"
echo "hello ${name}"
# Output: hello world

################### 只读变量 ###################
readonly_var="hello"
echo ${readonly_var}
# Output: hello
readonly readonly_var
# rword="bye"  # 如果放开注释，执行时会报错

################### 删除变量 ###################
dword="hello"  # 声明变量
echo ${dword}  # 输出变量值
# Output: hello

unset dword    # 删除变量
echo ${dword}
# Output: （空）
