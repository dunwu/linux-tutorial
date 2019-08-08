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
echo "${text} length is: ${#text}"
# Output:
# 12345 length is: 5

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

################### 截取关键字左边内容 ###################
full_branch="feature/1.0.0"
branch=`echo ${full_branch#feature/}`
echo "branch is ${branch}"

################### 截取关键字右边内容 ###################
full_version="0.0.1-SNAPSHOT"
version=`echo ${full_version%-SNAPSHOT}`
echo "version is ${version}"

################### 判断字符串中是否包含子字符串 ###################
result=$(echo "${str}" | grep "feature/")
if [[ "$result" != "" ]] ; then
  echo "feature/ 是 ${str} 的子字符串"
else
  echo "feature/ 不是 ${str} 的子字符串"
fi
