#!/bin/bash
#testing multiple commands in the then section
testuser=tiandi
if grep $testuser /etc/passwd
then
	echo The bash files from user $testuser are:
	ls -a /home/$testuser/.b*
fi
