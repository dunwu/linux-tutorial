#!/bin/bash
# shift n 移动变量

count=1
while [ -n "$1" ]
do
	echo "Parameter #$count = $1"
	count=$[ $count+1 ]
	shift
done

echo -e "\n"

# demonstrating a multi-position shift
echo "The original parameters : $*"
shift 2
echo "Here's the new first parameter: $1"
