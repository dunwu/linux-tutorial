#!/bin/bash
# processing options and parameters with getopts

while getopts :ab:cd opt
do
	case "$opt" in
	a) echo "Found the -a option";;
	b) echo "Found the -b option,with value $OPTARG";;
	c) echo "Found the -c option";;
	d) echo "Found the -d option";;
	*) echo "Unknown option: $opt";;
	esac
done
shift $[ $OPTIND - 1 ]
count=1
for param in "$@"
do
	echo "Parameter $count: $param"
	count=$[ $count + 1 ]
done
