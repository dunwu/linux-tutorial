#!/bin/bash
# redirecting input file descriptors

exec 3>&1
echo "This is the 3 file descriptor" >&3

exec 6>&0
exec 0<test

count=1
while read line
do
	echo "Line #$count: $line"
	count=$[ $count+1 ]
done
exec 0<&6
read -p "Are you done now?" answer
case $answer in
Y|y) echo "Goodbye";;
N|n) echo "Sorry, this is the end";;
esac

