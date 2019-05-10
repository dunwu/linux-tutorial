#!/bin/bash
#testing string equality

testuser=tiandi

if [ $USER = $testuser ]
then
	echo "Welcome $testuser"
fi
