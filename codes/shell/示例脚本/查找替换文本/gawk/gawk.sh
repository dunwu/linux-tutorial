#!/bin/bash

BEGIN {
print "The latest list of users and shells"
print "Userid	Shell"
print "------	-----"
FS=":"
}

{
print $1 "	" $7
}

END {
print "This concludes the listing"
}

#执行gawk命令截取/etc/passwd输出
#gawk -f gawk.sh /etc/passwd
