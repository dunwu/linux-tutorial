#!/bin/bash
# checking if a directory or a file exists

if [ -e $HOME ]
then
	echo "OK on the directory.now to check the file"
	#checking if a file exists
	if [ -e $HOME/testing ]
	then
		#the file exists,append data to it
		echo "Appending date to existing file"
		date >> $HOME/testing
	else
		#the file is not exists,create a new file
		echo "Creating a new file"
		date > $HOME/testing
	fi
else
	echo 'Sorry. you do not have a $HOME directory'
fi
