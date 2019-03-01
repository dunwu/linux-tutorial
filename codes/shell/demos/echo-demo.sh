#!/usr/bin/env bash

# 输出普通字符串
echo "hello, world"
#  Output: hello, world

# 输出含变量的字符串
echo "hello, \"zp\""
#  Output: hello, "zp"

# 输出含变量的字符串
name=zp
echo "hello, \"${name}\""
#  Output: hello, "zp"

# 输出含换行符的字符串
echo "YES\nNO"
#  Output: YES\nNO
echo -e "YES\nNO" # -e 开启转义
#  Output:
#  YES
#  NO

# 输出含不换行符的字符串
echo "YES"
echo "NO"
#  Output:
#  YES
#  NO

echo -e "YES\c" # -e 开启转义 \c 不换行
echo "NO"
#  Output:
#  YESNO

# 输出内容定向至文件
echo "test" > test.txt

# 输出执行结果
echo `pwd`
#  Output:(当前目录路径)
