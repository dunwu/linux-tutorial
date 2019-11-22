#!/usr/bin/env bash

# 使用 grep 命令可以用于在文件中查找指定文本

# 在二进制文件中查找字符串
file=$1
keyword=$2
strings ${file} | grep ${keyword}
