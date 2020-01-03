#!/usr/bin/env bash

FILE=log.txt

count=1
cat ${FILE} | while read line
do
	echo "$count: $line"
	count=$[ $count + 1 ]
done
echo "Finished reading."

