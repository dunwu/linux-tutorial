#!/bin/bash
# send data to the the table in the MYSQL database

MYSQL=`which mysql`

if [ $# -ne 2 ]
then
	echo "Usage:mtest2 emplid lastname firstname salary"
else
	#脚本变量一定要用双引号，字符串变量使用单引号
	statement=" insert into em_admin values(NULL, '$1', $2)"
	$MYSQL emwjs -u test <<EOF
	$statement
EOF
	if [ $? -eq 0 ]
	then
		echo Data successfully added
	else
		echo Problem adding data
	fi
fi
