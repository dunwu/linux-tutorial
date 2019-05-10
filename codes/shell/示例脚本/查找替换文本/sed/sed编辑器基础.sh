#!/bin/bash
#sed编辑器基础

#替换标记
sed 's/lazy/ht/' ./test

echo -e "next\n"

#可用的替换标记
#1.数字 表明新闻本将替换第几处模式匹配的地方
sed 's/lazy/ht/2' ./test
#2.g 表明新文件将会替换所有已有文本出现的地方
sed 's/lazy/ht/g' ./test
#3.p 表明原来行的内容要打印出来,替换后的
sed 's/lazy/ht/p' ./test
#4.w file 将替换的结果写到文件中
sed 's/lazy/ht/w test1' ./test

echo -e "next\n"

#替换字符
sed 's/\/bin\/bash/\/bin\/csh/' /etc/passwd
#或者
sed 's!/bin/bash!/bin/csh!' /etc/passwd

echo -e "next\n"

#使用地址
#1.数字方式的行寻址
sed '2s/lazy/cat/' ./test
sed '2,3s/lazy/cat/' ./test
sed '2,$s/lazy/cat/' ./test
#2.使用文本模式过滤器
sed '/tiandi/s/bash/csh/' /etc/passwd

echo -e "next\n"

#组合命令
sed '2{
s/fox/elephant/
s/dog/cat/
}' test
sed '2,${
s/fox/elephant/
s/dog/cat/
}' test

echo -e "next\n"

#删除行
sed '3d' ./test
sed '2,$d' ./test
sed '/number 1/d' ./test
#删除两个文本模式来删除某个范围的行，第一个开启删除功能，第二个关闭删除功能
sed '/1/,/3/d' ./test

echo -e "next\n"

#插入和附加文本
sed '3i\
This is an appended line.' ./test

sed '$a\
This is a new line of text.' ./test

#修改行
sed '3c\
This a changed line of text.' ./test
sed '/number 1/c\
This a changed line of text.' ./test
#替换两行文本
#sed '2,3c\
#This a changed line of text.' ./test

#转换命令，处理单个字符
#sed 'y/123/789/' ./test

echo -e "next\n"

#回顾打印
# p 打印文本行
# -n 禁止其他行，只打印包含匹配文本模式的行
sed -n '/number 3/p' ./test

#查看修改之前的行和修改之后的行
#sed -n '/3/{
#p
#s/line/test/p
#}' ./test

echo -e "next\n"

# 打印行号
sed '=' ./test

#打印指定的行和行号
#sed -n '/lazy/{
#=
#p
#}' ./test

#列出行 打印数据流中的文本和不可打印的ASCII字符，任何不可打印的字符都用它们的八进制值前加一个反斜线或标准C风格的命名法，比如用\t来代表制表符
sed -n 'l' ./test

