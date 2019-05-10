#!/bin/bash
var1=10
var2=5
if [ $var1 -gt 5 ]
then
	echo "The test value $var1 is greater than 5"
fi
if [ $var1 -eq $var2 ]
then
	echo "The values is equal"
else
	echo "The values are different"
fi


