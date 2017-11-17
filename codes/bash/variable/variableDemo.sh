#!/usr/bin/env bash

username="Zhang Peng" ### 声明变量
echo ${username} ### 输出变量的值
unset username ### 删除变量
echo ${username} ### 输出为空

export HELLO="Hello World" ### 输出环境变量
