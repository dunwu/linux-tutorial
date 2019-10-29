#!/usr/bin/env bash

# trapping the script exit

trap "echobyebye" EXIT

count=1
while [ $count -le 5 ]
do
	echo "Loop #$count"
	sleep 3
	count=$[ $count + 1 ]
done
