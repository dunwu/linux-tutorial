#!/bin/bash
# testing $* and $@

count=1
for param in "$*"
do
	echo "\$* Parameter #$count = $param"
	count=$[ $count+1 ]
done

count=1
for param in "$@"
do
	echo "\$@ Paramenter #$count = $param"
	count=$[ $count+1 ]
done
