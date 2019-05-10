#!/bin/bash

#using the case command

case $USER in
tiandi | barbar)
	echo "Welcome, $USER"
	echo "Pleas enjoy your visit";;
testing)
	echo "Special testing account";;
jessica)
	echo "Do not forget to logout when you are out";;
*)
	echo "Sorry, you are not allowed here";;
esac
