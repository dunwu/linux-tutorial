#!/bin/bash

# testing signal trapping

trap "echo 'Sorry! I have trapped Ctrl-C'" SIGINT SIGTERM

echo this is a test program

count=1

while [ $count -le 10 ]
do
	echo "Loop #$count"
	sleep 5
	count=$[ $count+1 ]
done
