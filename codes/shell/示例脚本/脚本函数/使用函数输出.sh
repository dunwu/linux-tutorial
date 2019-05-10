#!/bin/bash
# using the echo to return a value

function db1 {
	read -p "Enter a value:" value
	echo $[ $value*2 ]
}

result=`db1`
echo "The new value is $result"

