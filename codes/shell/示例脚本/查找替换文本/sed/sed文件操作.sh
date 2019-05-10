#!/bin/bash

#向文件写入
sed '1,2w test1' test1

echo -e "next\n"

#从文件读取
sed '3r ./test' ./test

echo -e "next\n"

#从文件读取，并插入字符流
sed '/lazy/r test' test

#向数据流末尾添加数据
sed '$r test' test

echo -e "next1\n"

sed '/lazy/ {
r test
d
}' test
