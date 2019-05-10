#!/bin/bash
# extracting command line options as parameters

while [ -n "$1" ]
do
	case "$1" in
	-a) echo "Found the -a option";;
	-b) echo "Found the -b optins";;
	-c) echo "Found the -c optins";;
	*) echo "$1 is not a valid options";;
	esac
	shift
done
