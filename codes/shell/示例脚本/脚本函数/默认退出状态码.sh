#!/bin/bash

# testing the exit status of a function

func1() {
	echo "Trying to display a non-existent file"
	ls -l badfile
}

#由于最后一条命令未执行成功，返回的状态码非0
echo "testing the function"
func1
echo "The exit status is : $?"

func2() {
	ls -l badfile
	echo "Another test to display a non-existent file"
}

#由于最后一条命令echo执行成功，返回的状态码为0
echo "Another test"
func2
echo "The exit status is : $?"





























