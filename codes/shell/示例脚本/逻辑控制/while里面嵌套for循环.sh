#!/bin/bash

# placing a for loop inside a while loop

var1=5

while [ $var1 -ge 0 ]
do
	echo "Outer loop: $var1"
	for (( var2=1; $var2 < 3; var2++))
	do
		var3=$[ $var1*$var2]
		echo "Inner loop: $var1 * $var2 = $var3"
	done
	var1=$[ $var1 - 1 ]
done
