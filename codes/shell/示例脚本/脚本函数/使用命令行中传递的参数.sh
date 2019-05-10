#!/bin/bash

# using a global variable to pass a value

function db1 {
	# $1和$2 不能从命令行中传递，只能调用函数时，手动传递
	echo $[ $1 * $2 ]
}

if [ $# -eq 2 ]
then
	value=`db1 $1 $2`
	echo "The result is $value"
else
	echo "Usage: badtest1 a b"
fi
