#!/bin/bash
#test命令中，大小字母会被当成小于小写字符，而在sort中，小写字母会先出现,test使用标准的ASCII排序，sort使用本地化语言设置进行排序，对于英语，本地化设置制定了排序顺序中小写字母出现在大写字母之前

var1=Testing
var2=testing

if [ $val1 \> $val2 ]
then
	echo '$val1 is greater than $val2'
else
	echo '$val1 is less than $val2'
fi
