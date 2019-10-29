#!/usr/bin/env bash

################### 使用单引号拼接字符串 ###################
name1='white'
str1='hello, '${name1}''
str2='hello, ${name1}'
echo ${str1}_${str2}
# Output:
# hello, white_hello, ${name1}

################### 使用双引号拼接字符串 ###################
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

# 获取子字符串
text="12345"
echo ${text:2:2}
# Output:
# 34

################### 查找子字符串 ###################
text="hello"
echo `expr index "${text}" ll`
# Output:
# 3

################### 判断字符串中是否包含子字符串 ###################
result=$(echo "${str}" | grep "feature/")
if [[ "$result" != "" ]]; then
	echo "feature/ 是 ${str} 的子字符串"
else
	echo "feature/ 不是 ${str} 的子字符串"
fi

################### 截取关键字左边内容 ###################
full_branch="feature/1.0.0"
branch=`echo ${full_branch#feature/}`
echo "branch is ${branch}"

################### 截取关键字右边内容 ###################
full_version="0.0.1-SNAPSHOT"
version=`echo ${full_version%-SNAPSHOT}`
echo "version is ${version}"

################### 字符串分割成数组 ###################
str="0.0.0.1"
OLD_IFS="$IFS"
IFS="."
array=( ${str} )
IFS="$OLD_IFS"
size=${#array[*]}
lastIndex=`expr ${size} - 1`
echo "数组长度：${size}"
echo "最后一个数组元素：${array[${lastIndex}]}"
for item in ${array[@]}
do
	echo "$item"
done

################### 判断字符串是否为空 ###################
#-n 判断长度是否非零
#-z 判断长度是否为零

str=testing
str2=''
if [[ -n "$str" ]]
then
	echo "The string $str is not empty"
else
	echo "The string $str is empty"
fi

if [[ -n "$str2" ]]
then
	echo "The string $str2 is not empty"
else
	echo "The string $str2 is empty"
fi

#	Output:
#	The string testing is not empty
#	The string  is empty

################### 字符串比较 ###################
str=hello
str2=world
if [[ $str = "hello" ]]; then
	echo "str equals hello"
else
	echo "str not equals hello"
fi

if [[ $str2 = "hello" ]]; then
	echo "str2 equals hello"
else
	echo "str2 not equals hello"
fi
