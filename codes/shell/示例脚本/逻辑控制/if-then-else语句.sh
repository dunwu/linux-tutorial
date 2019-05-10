#!/bin/bash
#testing the else section
testuser=badtest
if grep $testuser /etc/passwd
then
	echo The files for user $testuser are:
	ls -a /home/.b*
else
	echo "The user name $testuser does not exist on this system"
fi
