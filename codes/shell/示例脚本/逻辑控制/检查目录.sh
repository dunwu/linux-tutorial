#!/bin/bash
# look before you leap

if [ -d $HOME ]
then
	echo "Your home directory exists"
	cd $HOME
	ls -a
else
	echo "There is a problem with your HOME direcotry"
fi
