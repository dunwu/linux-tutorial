#!/bin/bash
# break n，默认为1

for (( a=1; a<=3; a++ ))
do
	echo "Outer loop : $a"
	for (( b=1; b < 100; b++ ))
	do 
		if [ $b -gt 4 ]
		then
			break 2
		fi
		echo " Inner loop:$b"
	done
done

