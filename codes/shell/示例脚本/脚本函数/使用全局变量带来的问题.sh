#!/bin/bash

# demonstrating a bad use of variables

function func1 {
	temp=$[ $value + 5 ]
	result=$[ $temp * 2 ]
}

temlp=4
value=6

func1
echo "The result is $result"

if [ $temp -gt $value ]
then
	echo "Temp is larger"
else
	echo "temp is smaller"
fi
