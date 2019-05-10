#!/bin/bash
#
# Snapshot_Stats - produces a report for system stats
#
##############################################
#
# Set Script Variables
#
DATE=`date +%m%d%y`
DISKS_TO_MONITOR="/dev/sda1"
MAIL=`which mutt`
MAIL_TO=tiandi
REPORT=/home/tiandi/Documents/Snapshot_Stats_$DATE.rpt
#
####################################################
#
# Create Report File
#
exec 3>&1             # Save file descriptor
#
exec 1> $REPORT       # direct output to rpt file
#
###################################################
#
echo
echo -e "\t\tDaily System Report"
echo
#
###################################################
# Date Stamp the Report
#
echo -e "Today is" `date +%m%d%y`
echo
#
##################################################
#
#1) Gather System Uptime Statistics
#
echo -e "System has been \c"
uptime | sed -n '/,/s/,/ /gp' | gawk '{if($4 == "days" || $4 == "day") {print $2,$3,$4,$5} else {print $2,$3}}'
#
#################################################
#
#2) Gather Disk Usage Statistics
#
echo
for DISK in $DISK_TO_MONITOR                 # loop to check disk space
do
	echo -e "$DISK usage: \c"
	df -h $DISK | sed -n '/% \//p' | gawk '{ print $5 }'
done
#
##################################################################
#
#3) Gather Memory Usage Statstics
#
echo
echo -e "Memory Usage: \c"
#
free | sed -n '2p' | gawk 'x = int(($3 / $2) * 100) {print x}' | sed 's/$/%/'
#
###############################################################
#
#4) Gather Number of Zombie Processes
#
echo
ZOMBIE_CHECK=`ps -al | gawk '{print $2,$4}' | grep Z`
#
if [ "$ZOMBIE_CHECK" = "" ]
then
	echo "No Zombie Process on System at this Time"
else
	echo "Current System Zombie Processes"
	ps -al | gawk '{print $2,$4}' | grep Z
fi
echo
#
#####################################################################
#
# Restore File Descriptor & Mail Report
#
exec 1>&3				# Restore output to STDOUT
#
#$MAIL -a $REPORT -s "System Sstatistics Report for $DATE"
#-- $MAIL_TO < /dev/null
#
###############################################################
#
# Clean up
#
#rm -f $REPORT
#
