#!/bin/bash

#多个空格只保留一个
#sed '/./,/^$/!d' test

#删除开头的空白行
#sed '/./,$!d' test

#删除结尾的空白行
sed '{
:start
/^\n*$/{$d; N; b start}
}' test

#删除html标签
#有问题
#s/<.*>//g

#sed 's/<[^>]*>//g' test1

#sed 's/<[^>]*>//g;/^$/d' test1
