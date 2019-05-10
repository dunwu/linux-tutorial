#!/bin/bash

#testing a multicommand while loop

var1=10
while echo $var1
	[ $var1 -ge 0 ]
do	
	echo 'This is inside the loop'
	var1=$[ $var1 - 1 ]
done
