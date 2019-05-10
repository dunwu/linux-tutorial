#!/bin/bash
#
# Big_Users - find big disk space users in various directories
#############################################################
#Parameters for script
#
CHECK_DIRECTORIES="/var/log /home" #directories to check
#
######################### Main Script #######################
#
DATE=$(date '+%m%d%y')             #Date for report file
#
exec > disk_space_$DATE.rpt         #Make report file Std Output
#
echo "Top Ten Disk Space Usage"     #Report header for while report
echo "for $CHECK_DIRECTORIES Directories"
#
for DIR_CHECK in $CHECK_DIRECTORIES       #loop to du directories
do
	echo ""
	echo "The $DIR_CHECK Directory:"	#Title header for each directory
#
#	Creating a listing of top ten disk space users
	du -S $DIR_CHECK 2>/dev/null |
	sort -rn |
	sed '{11,$D; =}' |
	sed 'N; s/\n/ /' | 
	gawk '{printf $1 ":" "\t" $2 "\t" $3 "\n"}'
#
done								#End of for loop for du directories
#
