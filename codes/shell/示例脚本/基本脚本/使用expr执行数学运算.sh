#!/bin/bash
#An example of using the expr command

var1=10
var2=20
var3=`expr $var2 / $var1`
echo "The result is $var3"

