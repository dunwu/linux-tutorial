#!/bin/bash
# using a variable to hold the list

list="Alabama Alaska Arizona"
list=$list" Connecticut"

for state in $list
do
	echo "Have you ever visited $state"
done

