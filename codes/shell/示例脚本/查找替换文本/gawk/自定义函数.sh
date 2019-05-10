#!/bin/bash
#gawk 自定义函数

gawk '
function myprint()
{
	printf "%-16s - %s\n", $1, $4
}
BEGIN{FS="\n"; RS=""}
{
	myprint()
}' test
