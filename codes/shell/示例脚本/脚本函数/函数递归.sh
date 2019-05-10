#!/bin/bash

function factorial {
	if [ $1 -eq 1 ]
	then
		echo 1
	else
		local temp=$[ $1 -1 ]
		local result=`factorial $temp`
		echo $[ $result * $1 ]
	fi
}

read -p "Please input a value: " value
result=`factorial $value`
echo "The factorial of $value is: $result"
