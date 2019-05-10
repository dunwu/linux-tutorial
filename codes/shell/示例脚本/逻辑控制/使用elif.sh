#!/bin/bash

# looking for a possible value

if [ $USER = "tiandi" ]
then 
	echo "Welcome $USER"
	echo "Please enjoy your visit"
elif [ $USER = testing ]
then
	echo "Welcome $USER"
	echo "Please enjoy your visit"
elif [ $USER = barbar ]
then
	echo "Do not forget to logout when you're done"
else
	echo "Sorry, you are not allowed here"
fi

