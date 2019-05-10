#!/bin/bash

var1=10.45
var2=43.67
var3=33.2
var4=71

var5=`bc <<EOF
scale=4
a1 = $var1 * $var2
b1 = $var3 * $var4
a1 + b1
EOF
`
echo The final answer for this mess is $var5
