#!/bin/bash

# using a function in script

function func1 {
	echo "This is an example of a function"
}

count=1
while [ $count -le 5 ]
do
	func1
	count=$[ $count+1 ]
done
echo "This is the end of the loop"
func1
echo "Now this is the end of the script"
