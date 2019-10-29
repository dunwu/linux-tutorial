#!/usr/bin/env bash

# count number of files in your PATH

mypath=`echo $PATH | sed 's/:/ /g'`
count=0
for directory in $mypath
do
	check=`ls $directory`
	echo $check
	for item in $check
	do
		count=$[ $count + 1 ]
	done
	echo "$directory - $count"
	count=0
done

