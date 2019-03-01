#!/usr/bin/env bash

################### 单引号和双引号 ###################
################### 拼接字符串 ###################
# 使用单引号拼接
name1='white'
str1='hello, '${name1}''
str2='hello, ${name1}'
echo ${str1}_${str2}
# Output:
# hello, white_hello, ${name1}

# 使用双引号拼接
name2="black"
str3="hello, "${name2}""
str4="hello, ${name2}"
echo ${str3}_${str4}
# Output:
# hello, black_hello, black

################### 获取字符串长度 ###################
text="12345"
echo ${#text}
# Output:
# 5

################### 获取字符串长度 ###################
text="12345"
echo ${text:2:2}
# Output:
# 34

################### 查找子字符串 ###################
text="hello"
echo `expr index "${text}" ll`
# Output:
# 3
